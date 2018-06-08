# frozen_string_literal: true

class TagSerializer < ActiveModel::Serializer
  attributes :id, :title, :stories_count, :color

  def stories_count
    object.stories.published.length
  end
end
