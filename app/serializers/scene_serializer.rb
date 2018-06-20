# frozen_string_literal: true

class SceneSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :story_id, :image, :is_end,
             :visible_name, :image_as_background, :default_image

  has_many :scene_actions

  def image
    object.image.try(:url)
  end

  def default_image
    ActionController::Base.helpers.image_url('default.jpg')
  end
end
