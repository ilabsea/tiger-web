# frozen_string_literal: true

class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image, :author, :source_link,
             :status, :user_id, :actived, :reason, :user, :published_at

  has_many :tags

  def image
    object.image.try(:url)
  end

  def user
    {
      email: object.user.email
    }
  end
end
