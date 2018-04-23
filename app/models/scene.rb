# frozen_string_literal: true

# == Schema Information
#
# Table name: scenes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  image       :string(255)
#  story_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Scene < ApplicationRecord
  has_many :scene_actions, dependent: :destroy
  belongs_to :story
end
