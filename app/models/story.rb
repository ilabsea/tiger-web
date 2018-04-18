# frozen_string_literal: true

# == Schema Information
#
# Table name: stories
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  image       :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Story < ApplicationRecord
  has_many :story_tags, dependent: :destroy
  has_many :tags, through: :story_tags
  has_many :scenes, dependent: :destroy
  has_many :scene_actions, dependent: :destroy

  accepts_nested_attributes_for :tags

  strip_attributes only: %i[title image]

  def tags=(tag_attributes)
    tag_attributes.each do |title|
      tag = Tag.find_or_create_by(title: title)
      tags << tag
    end
  end
end
