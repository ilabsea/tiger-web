# frozen_string_literal: true

module Api
  module V1
    class ConfirmationsController < ApiController
      skip_before_action :authenticate_with_token!

      def create
        user = User.confirm_by_token(user_params[:confirmation_token])

        if user.errors.empty?
          render json: user, status: :ok
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :confirmation_token)
      end
    end
  end
end
