# frozen_string_literal: true

module Api
  module V1
    module Tags
      class StoriesController < ApiController
        skip_before_action :authenticate_with_token!

        def index
          @tag = Tag.find(params[:tag_id])
          @stories = @tag.stories.includes(:user, :tags).order('created_at desc').page(params[:page]).per(params[:per_page])

          render json: @stories, meta: pagination(@stories), status: :ok
        end
      end
    end
  end
end
