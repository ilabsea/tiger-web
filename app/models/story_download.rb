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
#  user_type   :string(255)
#

class StoryDownload < ApplicationRecord
  belongs_to :story

  scope :by_story, ->(story_id) { where(story_id: story_id) if story_id.present? }

  def self.between(from_date, to_date)
    where(created_at: [from_date..to_date])
  end

  def self.chart_of(from, to, options = {})
    story_downloads = all
    story_downloads = story_downloads.where(user_type: options[:user_type]) if options[:user_type].present?
    story_downloads = story_downloads.where(story_id: StoryTag.where(tag_id: options[:tag_id]).select(:story_id)) if options[:tag_id].present?
    story_downloads = story_downloads.group_by_day(:created_at, format: '%B %d, %Y', range: from..to).count
    story_downloads
  end
end
