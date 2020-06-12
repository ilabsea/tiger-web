# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :story, optional: true

  validates :title, presence: true
  validates :body, presence: true

  before_create :set_uuid
  after_commit :push_notification, on: :create

  def push_notification
    NotificationWorker.perform_async(id)
  end

  def build_content
    return story.build_content if story.present?

    { notification: { title: title, body: body } }
  end

  private
    def set_uuid
      self.uuid = SecureRandom.hex(4)
    end
end
