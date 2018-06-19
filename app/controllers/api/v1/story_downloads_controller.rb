# frozen_string_literal: true

module Api
  module V1
    class StoryDownloadsController < ApiController
      skip_before_action :authenticate_with_token!
      authorize_resource :story, :story_download, :story_read, parent: false
      before_action :set_period

      def index
        if protected_params[:tag_id].present?
          story_ids = Story.where(id: StoryTag.select(:story_id).where(tag_id: protected_params[:tag_id])).select(&:id)
        end

        @story_downloads = StoryDownload.between(@from_date, @to_date).includes(:story)
        @story_reads = StoryRead.between(@from_date, @to_date).includes(:story)

        if story_ids
          @story_downloads = @story_downloads.where(story_id: story_ids)
          @story_reads = @story_reads.where(story_id: story_ids)
        end

        respond_to do |format|
          format.xlsx {
            response.headers['Content-Disposition'] = "attachment; filename='dashbaord-#{Time.now}.xlsx'; encoding: 'base64'"
          }
        end
      end

      private

      def protected_params
        params.permit(:from, :to, :tag_id)
      end

      def set_period
        @from_date = Time.parse protected_params[:from]
        @to_date = Time.parse protected_params[:to]
      end
    end
  end
end
