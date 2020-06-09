# frozen_string_literal: true
class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :title, :body, :creator

  def creator
    { email: object.creator.email }
  end
end
