# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApiController
      skip_before_action :authenticate_with_token!

      def create
        user_password = params[:session][:password]
        user_email = params[:session][:email]
        user = user_email.present? && User.find_by(email: user_email)

        if user&.valid_password?(user_password)
          unless user.active_for_authentication?
            render json: { errors: 'Your account is unprocessable!' }, status: :unprocessable_entity
            return
          end

          user.regenerate_authentication_token
          user.save

          render json: user, root: false, status: :ok
        else
          render json: { errors: 'Invalid email or password' }, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find_by(authentication_token: params[:id])
        user.regenerate_authentication_token
        user.save
        head :no_content
      end
    end
  end
end
