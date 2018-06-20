# frozen_string_literal: true

module Api
  module V1
    class ChartsController < ApiController
      authorize_resource :story, :story_download, :story_read, parent: false

      def show
        tags = Tag.joins(:story_tags).group('story_tags.tag_id')
        story_chart = StoryChart.new(data_params)

        render json: story_chart.data, meta: { tags: tags }, root: 'data', status: :ok
      end

      private

      def data_params
        params.permit(:tag_id, :period, :period_unit, :from, :to)
      end
    end
  end
end
