# frozen_string_literal: true

class SceneActionSerializer < ActiveModel::Serializer
  attributes :id, :name, :parent_id, :story_id

  belongs_to :scene
  has_many :nodes

  def nodes
    object.children.map do |node|
      SceneActionSerializer.new(node).serializable_hash
    end
  end
end
