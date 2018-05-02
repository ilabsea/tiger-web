# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < ApiController
      before_action :grab_story_from_story_id
      authorize_resource

      def index
        @questions = @story.questions.page(params[:page]).per(params[:per_page])

        render json: @questions, meta: pagination(@questions)
      end

      def create
        @question = @story.questions.new(question_params)

        if @question.save
          render json: @question, status: :created
        else
          render json: @question.errors, status: :unprocessable_entity
        end
      end

      def update
        @question = @story.questions.find(params[:id])

        if @question.update_attributes(question_params)
          render json: @question, status: :ok
        else
          render json: @question.errors, status: :unprocessable_entity
        end
      end

      def update_order
        @story.questions.update_order!(params.require(:data))

        head :ok
      end

      def destroy
        @question = @story.questions.find(params[:id])

        if @question.destroy
          head :ok
        else
          render json: @question.errors, status: :unprocessable_entity
        end
      end

      private

      def question_params
        params.require(:question).permit(:id, :label, choices_attributes: %i[id label answered _destroy])
      end

      def grab_story_from_story_id
        @story = Story.find(params[:story_id])
      end
    end
  end
end
