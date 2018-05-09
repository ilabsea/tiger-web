# frozen_string_literal: true

# == Schema Information
#
# Table name: story_reads
#
#  id         :integer          not null, primary key
#  story_id   :integer
#  user_uuid  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StoryRead < ApplicationRecord
  belongs_to :story

  scope :by_story, ->(story_id) { where(story_id: story_id) if story_id.present? }
end
