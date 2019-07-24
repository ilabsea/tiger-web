# frozen_string_literal: true
# == Schema Information
#
# Table name: stories
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :text(65535)
#  image        :string(255)
#  user_id      :integer
#  status       :string(255)
#  actived      :boolean          default(TRUE)
#  reason       :text(65535)
#  published_at :datetime
#  author       :string(255)
#  source_link  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  license      :string(255)
#


class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image, :author, :source_link, :license,
             :status, :user_id, :actived, :reason, :user, :published_at, :tags

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
