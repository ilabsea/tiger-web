# frozen_string_literal: true

module Api
  module V1
    class ScenesController < ApiController
      before_action :grab_story_from_story_id
      authorize_resource

      def index
        @scenes = @story.scenes.roots

        render json: @scenes, meta: { story: @story }, status: :ok
      end

      def create
        @scene = @story.scenes.new(scene_params)
        @scene.image = params[:file]

        if @scene.save
          render json: @scene, status: :created
        else
          render json: @scene.errors, status: :unprocessable_entity
        end
      end

      def update
        @scene = @story.scenes.find(params[:id])
        @scene.image = params[:file] if params[:file].present?

        if @scene.update_attributes(scene_params)
          render json: @scene, status: :ok
        else
          render json: @scene.errors, status: :unprocessable_entity
        end
      end

      def update_order
        @story.scenes.update_order!(params.require(:data))

        head :ok
      end

      def destroy
        @scene = @story.scenes.find(params[:id])

        if @scene.destroy
          head :ok
        else
          render json: @scene.errors, status: :unprocessable_entity
        end
      end

      private

      def scene_params
        params[:data] = JSON.parse(params['data'])
        params[:data].require(:scene).permit(
          :id, :name, :parent_id, :description, :image, :story_id,
          :visible_name, :image_as_background, :remove_image,
          scene_actions_attributes: %i[id name display_order link_scene_id use_next story_id _destroy]
        )
      end

      def grab_story_from_story_id
        @story = Story.find(params[:story_id])
      end
    end
  end
end
