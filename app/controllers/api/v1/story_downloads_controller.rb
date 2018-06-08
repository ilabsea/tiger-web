# frozen_string_literal: true

module Api
  module V1
    class StoryDownloadsController < ApiController
      skip_before_action :authenticate_with_token!

      def create
        story_download = StoryDownload.new(story_download_params)

        if story_download.save
          render json: story_download, status: :created
        else
          render json: story_download.errors, status: :unprocessable_entity
        end
      end

      private

      def story_download_params
        params.permit(:story_id, :device_type)
      end
    end
  end
end
