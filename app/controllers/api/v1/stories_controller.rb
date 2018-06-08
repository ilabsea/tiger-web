# frozen_string_literal: true

module Api
  module V1
    class StoriesController < ApiController
      load_resource only: :index
      skip_before_action :authenticate_with_token!, only: :index
      authorize_resource

      def index
        @stories = @stories.includes(:user, :tags).order('created_at desc').page(params[:page]).per(params[:per_page])

        render json: @stories, meta: pagination(@stories)
      end

      def create
        @story = current_user.stories.new(story_params)
        @story.image = params[:file]

        if @story.save
          render json: @story, status: :created
        else
          render json: @story.errors, status: :unprocessable_entity
        end
      end

      def update
        @story = Story.find(params[:id])
        @story.image = params[:file] if params[:file].present?

        if @story.update_attributes(story_params)
          render json: @story, status: :ok
        else
          render json: @story.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @story = current_user.stories.find(params[:id])

        if @story.destroy
          head :ok
        else
          render json: @story.errors, status: :unprocessable_entity
        end
      end

      def clone
        story = ::StoryContentDuplicator.new(params[:id])

        if story.dup
          render json: story.child, status: :created
        else
          render json: story.child.errors, status: :unprocessable_entity
        end
      end

      private

      def story_params
        params[:my_story] ||= JSON.parse(params['data'])
        params[:my_story].require(:story).permit(
          :id, :title, :description, :actived, :author, :source_link, :published_at,
          :reason, :status, :image, tags_attributes: %i[id title _destroy]
        )
      end
    end
  end
end
