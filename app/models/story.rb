# frozen_string_literal: true

# == Schema Information
#
# Table name: stories
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :text(65535)
#  image        :string(255)
#  user_id      :integer
#  status       :string(255)
#  actived      :boolean          default(TRUE)
#  reason       :text(65535)
#  published_at :datetime
#  author       :string(255)
#  source_link  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Story < ApplicationRecord
  belongs_to :user
  has_many :story_tags, dependent: :destroy
  has_many :tags, through: :story_tags
  has_many :scenes, dependent: :destroy
  has_many :scene_actions, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :story_downloads, dependent: :destroy
  has_many :story_reads, dependent: :destroy

  STATUSED = %w[new pending published rejected archived].freeze

  accepts_nested_attributes_for :tags

  strip_attributes only: %i[title image]

  mount_uploader :image, ImageUploader

  validates :status, inclusion: { in: STATUSED }
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :source_link, format: { with: %r(\A^(https?\:\/\/)?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}((\/|\?)\S*)?$\z) }, allow_blank: true

  scope :actives, -> { where(actived: true) }
  scope :exclude_archives, -> { where.not(status: 'archived').order('created_at desc') }
  scope :exclude_news, -> { where.not(status: 'new') }
  scope :published, -> { where(status: 'published') }

  ## Callbacks
  before_validation :set_default_status, on: :create
  before_save :set_author
  before_save :set_protocol, if: ->(obj) { obj.source_link.present? }

  def tags_attributes=(attributes)
    attributes.each do |attribute|
      if attribute[:id].blank?
        tag = Tag.find_or_create_by(title: attribute[:title])
        tags << tag
        next
      end

      if attribute[:_destroy].present?
        story_tag = story_tags.find_by(tag_id: attribute[:id])
        story_tag.destroy
      end
    end
  end

  def self.filter(params)
    relation = all
    relation = relation.where(status: params[:status]) if params[:status].present?
    relation = relation.where(actived: params[:actived]) if params[:actived].present?
    relation = relation.order('created_at desc')
    relation
  end

  private

  def set_default_status
    self.status ||= 'new'
  end

  def set_protocol
    self.source_link = source_link.start_with?('http://', 'https://') ? source_link : "http://#{source_link}"
  end

  def set_author
    self.author ||= user.present? && user.email.split('@').first
  end
end
