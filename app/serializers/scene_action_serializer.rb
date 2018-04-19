# frozen_string_literal: true

class SceneActionSerializer < ActiveModel::Serializer
  attributes :id, :name, :parent_id, :link_scene_id, :scene_id, :story_id

  belongs_to :link_scene
end
