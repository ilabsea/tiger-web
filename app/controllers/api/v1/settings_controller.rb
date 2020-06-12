# frozen_string_literal: true
module Api
  module V1
    class SettingsController < ApiController
      authorize_resource

      def show
        render json: { notification_options: Setting.notification_options }
      end

      def create
        setting_params.keys.each do |key|
          Setting.send("#{key}=", setting_params[key]) unless setting_params[key].nil?
        end

        render json: { notification_options: Setting.notification_options }, status: :created
      end

      private
        def setting_params
          params.require(:setting).permit(notification_options: {})
        end
    end
  end
end
