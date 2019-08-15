# frozen_string_literal: true
class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image, :author, :source_link, :license,
             :status, :user_id, :actived, :reason, :user, :published_at, :tags, :has_audio

  def tags
    object.tags.map { |tag| { id: tag.id, title: tag.title } }
  end

  def image
    object.image.try(:url)
  end

  def user
    {
      email: object.user.email
    }
  end
end
