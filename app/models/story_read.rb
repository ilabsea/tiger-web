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
#  user_type     :string(255)
#

class StoryRead < ApplicationRecord
  belongs_to :story
  has_many :story_responses, dependent: :destroy
  has_many :quiz_responses, dependent: :destroy

  accepts_nested_attributes_for :story_responses
  accepts_nested_attributes_for :quiz_responses

  scope :by_story, ->(story_id) { where(story_id: story_id) if story_id.present? }

  def self.between from_date, to_date
    where(created_at: [from_date..to_date])
  end

  def self.chart_of(from, to, tag_id = nil)
    story_reads = tag_id.nil? ? all : where(story_id: StoryTag.where(tag_id: tag_id).select(:story_id))

    story_reads.group_by_day(:created_at, format: '%B %d, %Y', range: from..to).count
  end
end
