# frozen_string_literal: true

module Api
  module V1
    class StoryReadsController < ApiController
      skip_before_action :authenticate_with_token!

      def create
        story_read = StoryRead.new(story_read_params)

        if story_read.save
          render json: story_read, status: :created
        else
          render json: story_read.errors, status: :unprocessable_entity
        end
      end

      private

      def story_read_params
        params.permit(:story_id, :user_uuid, :finished_at, :quiz_finished,
                      story_responses_attributes: %i[scene_id scene_action_id],
                      quiz_responses_attributes: %i[question_id choice_id])
      end
    end
  end
end
