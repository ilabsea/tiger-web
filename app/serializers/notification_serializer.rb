# frozen_string_literal: true
class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :title, :body, :creator, :created_at, :success_count, :failure_count

  def creator
    { email: object.creator.email }
  end
end
