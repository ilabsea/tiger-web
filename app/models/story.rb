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
#  license      :string(255)
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
  LICENSES = [
    'Attribution 4.0 International (CC BY 4.0)',
    'Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)',
    'Attribution-NoDerivatives 4.0 International (CC BY-ND 4.0)',
    'Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)',
    'Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)',
    'Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)'
  ].freeze

  accepts_nested_attributes_for :tags

  strip_attributes only: %i[title image]

  mount_uploader :image, ImageUploader

  validates :license, presence: true, inclusion: { in: LICENSES }
  validates :status, inclusion: { in: STATUSED }
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  scope :actives, -> { where(actived: true) }
  scope :exclude_archives, -> { where.not(status: 'archived').order('created_at desc') }
  scope :exclude_news, -> { where.not(status: 'new') }
  scope :published, -> { where(status: 'published') }

  ## Callbacks
  before_validation :set_default_status, on: :create
  before_save :set_author
  after_update :push_notification, if: -> { saved_change_to_attribute?('status') && status == 'published' }

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

  def has_audio?
    scenes.where.not(audio: nil).count > 0 || (questions.where.not(audio: nil).or(questions.where.not(educational_message_audio: nil))).count > 0
  end

  def push_notification
    Setting.clear_cache
    return unless Setting.notification_options['story_enable_pushing']

    StoryWorker.perform_async(id)
  end

  def build_content
    titl = Setting.notification_options['story_notification_title'].gsub(/\{title\}/, title)
    bodi = Setting.notification_options['story_notification_body'].gsub(/\{title\}/, title)

    { notification: { title: titl, body: bodi }, data: {story: StorySerializer.new(self).to_json} }
  end

  def self.filter(params)
    relation = all
    relation = relation.where(status: params[:status]) if params[:status].present?
    relation = relation.where(actived: params[:actived]) if params[:actived].present?
    relation = relation.order('created_at desc')
    relation
  end

  def self.licenses
    LICENSES
  end

  private

  def set_default_status
    self.status ||= 'new'
  end

  def set_author
    self.author ||= user.present? && user.email.split('@').first
  end
end
