# frozen_string_literal: true

module Authenticable
  def current_user
    User.where(authentication_token: request.headers['Authorization'])
        .where('token_expired_date >= ?', ENV['TOKEN_EXPIRED_IN_MONTH'].to_i.month.ago).first
  end

  def authenticate_with_token!
    render json: { errors: 'Not authenticated' }, status: :unauthorized unless current_user.present?
  end
end
