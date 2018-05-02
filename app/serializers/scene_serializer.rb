# frozen_string_literal: true

class SceneSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :story_id, :image

  has_many :scene_actions

  def image
    object.image.try(:url)
  end
end
