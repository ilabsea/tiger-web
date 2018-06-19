# frozen_string_literal: true

# == Schema Information
#
# Table name: story_downloads
#
#  id          :integer          not null, primary key
#  story_id    :integer
#  device_type :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class StoryDownload < ApplicationRecord
  belongs_to :story

  scope :by_story, ->(story_id) { where(story_id: story_id) if story_id.present? }

  def self.between from_date, to_date
    where(created_at: [from_date..to_date])
  end

  def self.chart_of(from, to, tag_id = nil)
    story_downloads = tag_id.nil? ? all : where(story_id: StoryTag.where(tag_id: tag_id).select(:story_id))
    
    story_downloads.group_by_day(:created_at, format: '%B %d, %Y', range: from..to).count
  end
end
