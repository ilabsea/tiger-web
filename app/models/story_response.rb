# frozen_string_literal: true

# == Schema Information
#
# Table name: story_responses
#
#  id              :integer          not null, primary key
#  scene_id        :integer
#  scene_action_id :integer
#  story_read_id   :integer
#

class StoryResponse < ApplicationRecord
  belongs_to :story_read
end
