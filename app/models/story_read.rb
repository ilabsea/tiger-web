# frozen_string_literal: true

# == Schema Information
#
# Table name: story_reads
#
#  id            :integer          not null, primary key
#  story_id      :integer
#  finished_at   :datetime
#  quiz_finished :boolean
#  user_uuid     :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class StoryRead < ApplicationRecord
  belongs_to :story
  has_many :story_responses
  has_many :quiz_responses

  accepts_nested_attributes_for :story_responses
  accepts_nested_attributes_for :quiz_responses

  scope :by_story, ->(story_id) { where(story_id: story_id) if story_id.present? }
end
