# frozen_string_literal: true

module Api
  module V1
    class StoryDownloadsController < ApiController
      authorize_resource

      def index
        stories = Story.exclude_news.select(:id, :title, :status)
        story_chart = StoryChart.new(
          story_id: params[:story_id],
          period: params[:period],
          period_unit: params[:period_unit]
        )

        render json: story_chart.data, root: 'data', meta: { stories: stories }, status: :ok
      end

      def create
      end

      private

      def download_params
      end
    end
  end
end
