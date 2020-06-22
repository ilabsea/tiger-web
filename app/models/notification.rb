# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :story, optional: true

  validates :body, presence: true

  before_create :set_uuid
  after_commit :push_notification, on: :create

  def push_notification
    NotificationWorker.perform_async(id)
  end

  def build_content
    content = { notification: { title: title, body: body } }
    content[:data] = { story: StorySerializer.new(story).to_json } if story.present?
    content
  end

  private
    def set_uuid
      self.uuid = SecureRandom.hex(4)
    end
end
