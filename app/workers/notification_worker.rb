# frozen_string_literal: true

require 'fcm'

class NotificationWorker
  include Sidekiq::Worker

  def perform(notification_id)
    @notification = Notification.find_by(id: notification_id)

    return if @notification.nil?

    fcm = FCM.new(ENV['FIREBASE_SERVER_KEY'])

    RegisteredToken.in_batches do |relation|
      registration_ids = relation.pluck(:token)

      response = fcm.send(registration_ids, @notification.build_content)

      res_body = JSON.parse(response[:body])
      @notification.update_attributes(success_count: res_body['success'].to_i, failure_count: res_body['failure'].to_i)
    end
  end
end
