# frozen_string_literal: true
class SceneSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :story_id, :image, :is_end,
             :visible_name, :image_as_background, :audio

  has_many :scene_actions

  def image
    object.image.try(:url)
  end

  def audio
    object.audio.try(:url)
  end
end
