# frozen_string_literal: true

module Authenticable
  def current_user
    User.where(authentication_token: request.headers['Authorization'])
        .where('token_expired_date >= ?', Time.zone.now).first
  end

  def authenticate_with_token!
    render json: { errors: 'Not authenticated' }, status: :unauthorized unless current_user.present?
  end
end
