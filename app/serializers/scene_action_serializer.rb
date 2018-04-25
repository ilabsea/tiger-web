# frozen_string_literal: true

class SceneActionSerializer < ActiveModel::Serializer
  attributes :id, :name, :parent_id, :link_scene_id, :scene_id, :story_id, :link_scene

  def link_scene
    object.link_scene
  end
end
