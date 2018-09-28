# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      skip_before_action :authenticate_with_token!, only: :create
      authorize_resource

      def index
        users = User.all_except(current_user).filter(params).page(params[:page]).per(params[:per_page])
        render json: users, meta: pagination(users)
      end

      def create
        user = User.new(user_params)
        authorize! :create, user

        if user.save
          render json: user, status: :created
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      def update
        user = User.find(params[:id])
        if (user_params[:password].blank? && user_params[:password_confirmation].blank? &&
          user.update_without_password(user_params)) || user.update(user_params)
          render json: user, status: :ok
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find(params[:id])
        if user.soft_delete
          render json: user, status: :ok
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role, :status)
      end
    end
  end
end
