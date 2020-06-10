# frozen_string_literal: true

require 'fcm'

class StoryWorker
  include Sidekiq::Worker

  def perform(story_id)
    @story = Story.find_by(id: story_id)

    return if @story.nil?

    fcm = FCM.new(ENV['FIREBASE_SERVER_KEY'])

    RegisteredToken.in_batches do |relation|
      registration_ids = relation.pluck(:token)

      response = fcm.send(registration_ids, @story.build_content)
    end
  end
end
