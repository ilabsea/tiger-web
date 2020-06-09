# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApiController
      authorize_resource

      def index
        @notifications = Notification.joins(:creator).page(params[:page]).per(params[:per_page])

        render json: @notifications, meta: pagination(@notifications)
      end

      def create
        @notification = current_user.notifications.new(notification_params)

        if @notification.save
          render json: @notification, status: :created
        else
          render json: @notification.errors, status: :unprocessable_entity
        end
      end

      private
        def notification_params
          params.require(:notification).permit(
            :id, :title, :body, :success_count, :failure_count
          )
        end
    end
  end
end
