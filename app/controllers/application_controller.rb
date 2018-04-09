# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_breadcrumb 'Home', :root_path

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  private

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def authenticate_user!(options = {})
    if user_signed_in?
      super(options)
    else
      redirect_to new_user_session_path
    end
  end
end
