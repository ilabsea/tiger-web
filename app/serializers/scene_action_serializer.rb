# frozen_string_literal: true

class SceneActionSerializer < ActiveModel::Serializer
  attributes :id, :name, :link_scene_id, :scene_id, :story_id, :link_scene, :use_next

  def link_scene
    if object.use_next
      arr = object.scene.self_and_siblings
      index = arr.find_index { |a| a.id == object.scene.id }
      arr[index + 1] || {}
    else
      object.link_scene
    end
  end
end
