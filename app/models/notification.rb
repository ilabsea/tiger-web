# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  validates :title, presence: true
  validates :body, presence: true

  before_create :set_uuid
  after_create :push_notification

  def push_notification
    NotificationWorker.perform_async(id)
  end

  def build_content
    { notification: { title: title, body: body } }
  end

  private
    def set_uuid
      self.uuid = SecureRandom.hex(4)
    end
end
