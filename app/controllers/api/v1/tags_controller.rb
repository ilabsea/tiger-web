# frozen_string_literal: true

module Api
  module V1
    class TagsController < ApiController
      skip_before_action :authenticate_with_token!

      def index
        @tags = Tag.joins(:story_tags).joins(:stories).where(stories: { status: 'published' }).includes(:stories)

        render json: @tags, status: :ok
      end
    end
  end
end
