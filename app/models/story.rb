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
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Story < ApplicationRecord
  belongs_to :user
  has_many :story_tags, dependent: :destroy
  has_many :tags, through: :story_tags
  has_many :scenes, dependent: :destroy
  has_many :scene_actions, dependent: :destroy

  STATUSED = %w[new published unpublished archived].freeze

  accepts_nested_attributes_for :tags

  strip_attributes only: %i[title image]

  mount_uploader :image, ImageUploader

  before_validation :set_default_status, on: :create

  validates :status, inclusion: { in: STATUSED }
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  scope :actives, -> { where(actived: true) }
  scope :exclude_archives, -> { where.not(status: 'archived').order('created_at desc') }

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

  private

  def set_default_status
    self.status ||= 'new'
  end
end
