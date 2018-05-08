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

  def self.filter(params = {})
    relations = where(created_at: params[:period].beginning_of_day..Time.zone.now)
    relations = relations.where(story_id: params[:story_id]) if params[:story_id].present?
    relations = relations.group('date(created_at)')
    relations = relations.select('created_at, COUNT(*) as count')
    relations.each_with_object({}) do |relation, obj|
      obj[relation.created_at.to_date] = relation.count
    end
  end
end
