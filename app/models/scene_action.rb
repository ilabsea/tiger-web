# frozen_string_literal: true

# == Schema Information
#
# Table name: scene_actions
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  parent_id      :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#  link_scene_id  :integer
#  scene_id       :integer
#  story_id       :integer
#

class SceneAction < ApplicationRecord
  belongs_to :scene
  belongs_to :story
  belongs_to :link_scene, class_name: 'Scene', foreign_key: :link_scene_id

  acts_as_nested_set dependent: :destroy, counter_cache: :children_count,
                     scope: %i[scene_id story_id]

  validates :name, :scene_id, :story_id, presence: true

  default_scope { order(lft: :asc) }

  def self.update_order!(actions)
    previous = nil
    actions.each do |action|
      current = find(action[:id])
      previous.present? ? current.move_to_right_of(previous) : current.move_to_root

      update_child_order(action, current) if action[:nodes].present?
      previous = current
    end
  end

  def self.update_child_order(child, parent)
    child[:nodes].each do |action|
      current = find(action[:id])
      current.move_to_child_of(parent)

      update_child_order(action, current) if action[:nodes].present?
    end
  end

  private_class_method :update_child_order
end
