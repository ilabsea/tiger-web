# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authenticate_with_token!

      protected

      def pagination(paginated_array)
        { pagination: { total_pages: paginated_array.total_pages,
                        total_objects: paginated_array.total_count } }
      end
    end
  end
end
