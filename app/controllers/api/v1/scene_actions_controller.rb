# frozen_string_literal: true

module Api
  module V1
    class SceneActionsController < ApiController
      before_action :grab_scene_from_scene_id
      authorize_resource

      def index
        @scene_actions = @scene.scene_actions

        render json: @scene_actions,
               root: 'data',
               meta: { scenes: @story.scenes.exclude_me(params[:scene_id]), story: @story },
               status: :ok
      end

      def create
        @scene_action = @scene.scene_actions.new(scene_action_params)

        if @scene_action.save
          render json: @scene_action, status: :created
        else
          render json: @scene_action.errors, status: :unprocessable_entity
        end
      end

      def update
        @scene_action = @scene.scene_actions.find(params[:id])
        @scene_action.image = params[:file] if params[:file].present?

        if @scene_action.update_attributes(scene_action_params)
          render json: @scene_action, status: :ok
        else
          render json: @scene_action.errors, status: :unprocessable_entity
        end
      end

      def update_order
        @scene.scene_actions.update_order!(params.require(:data))

        head :ok
      end

      def destroy
        @scene_action = @scene.scene_actions.find(params[:id])

        if @scene_action.destroy
          head :ok
        else
          render json: @scene_action.errors, status: :unprocessable_entity
        end
      end

      private

      def scene_action_params
        params.require(:scene_action).permit(:id, :name, :use_next, :link_scene_id, :scene_id, :story_id)
      end

      def grab_scene_from_scene_id
        @scene = Scene.find(params[:scene_id])
        @story = @scene.story
      end
    end
  end
end
