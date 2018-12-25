# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role, :authentication_token, :status

  def status
    return 'approved' if object.status == 'actived' && !object.confirmed?

    object.status
  end
end
