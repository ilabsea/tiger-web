# frozen_string_literal: true

module Api
  module V1
    class ChartsController < ApiController
      authorize_resource :story, :story_download, :story_read, parent: false

      def show
        stories = Story.exclude_news.select(:id, :title, :status)
        story_chart = StoryChart.new(data_params)

        render json: story_chart.data, root: 'data', meta: { stories: stories }, status: :ok
      end

      private

      def data_params
        params.permit(:story_id, :period, :period_unit, :from, :to)
      end
    end
  end
end
