# frozen_string_literal: true

# == Schema Information
#
# Table name: scene_actions
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  display_order :integer
#  link_scene_id :integer
#  use_next      :boolean          default(FALSE)
#  scene_id      :integer
#  story_id      :integer
#

class SceneAction < ApplicationRecord
  belongs_to :scene, optional: true
  belongs_to :story
  belongs_to :link_scene, class_name: 'Scene', foreign_key: :link_scene_id, optional: true

  validates :name, :story_id, presence: true

  default_scope { order(display_order: :asc) }
end
