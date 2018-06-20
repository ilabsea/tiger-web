# frozen_string_literal: true

class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image, :status, :user_id, :actived, :reason

  def image
    object.image.try(:url)
  end

  has_many :tags
  has_one :user
end
