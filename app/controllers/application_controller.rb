# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Authenticable

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    render json: { errors: exception.message }, status: :unauthorized
  end
end
