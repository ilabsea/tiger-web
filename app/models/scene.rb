# frozen_string_literal: true

# == Schema Information
#
# Table name: scenes
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  description         :text(65535)
#  image               :string(255)
#  parent_id           :integer
#  lft                 :integer          not null
#  rgt                 :integer          not null
#  story_id            :integer
#  visible_name        :boolean          default(TRUE)
#  image_as_background :boolean          default(FALSE)
#  is_end              :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Scene < ApplicationRecord
  has_many :scene_actions, dependent: :destroy
  belongs_to :story

  validates :name, :description, presence: true

  default_scope { order(lft: :asc) }
  scope :exclude_me, ->(id) { where.not(id: id) }

  mount_uploader :image, ImageUploader

  acts_as_nested_set dependent: :destroy, scope: [:story_id]

  accepts_nested_attributes_for :scene_actions, allow_destroy: true, reject_if: ->(a) { a[:name].blank? }

  ## Class Methods
  def self.update_order!(ids)
    previous = nil

    ids.each do |id|
      current = find(id)
      previous.present? ? current.move_to_right_of(previous) : current.move_to_root
      previous = current
    end
  end
end
