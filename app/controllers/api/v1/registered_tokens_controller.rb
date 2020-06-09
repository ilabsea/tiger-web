# frozen_string_literal: true

module Api
  module V1
    class RegisteredTokensController < ApiController
      skip_before_action :authenticate_with_token!

      def create
        @token = RegisteredToken.find_or_initialize_by(token: token_params[:token])

        if @token.save
          render json: @token, status: :created
        else
          render json: @token.errors, status: :unprocessable_entity
        end
      end

      private

      def token_params
        params.require(:registered_token).permit(:id, :token)
      end
    end
  end
end
