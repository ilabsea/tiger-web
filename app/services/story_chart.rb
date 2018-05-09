# frozen_string_literal: true

class StoryChart
  attr_reader :options

  def initialize(params = {})
    @options = {
      story_id: params[:story_id],
      period: params[:period].try(:to_i) || 7,
      period_unit: params[:period_unit].try(:downcase) || 'days'
    }
  end

  def data
    return group_by_month if %w[month months].include?(options[:period_unit])
    return group_by_lifetime if options[:period_unit] == 'lifetime'

    group_by_day
  end

  private

  def group_by_month
    start = options[:period].months.ago
    downloads = StoryDownload.by_story(options[:story_id]).group_by_month(:created_at, format: '%b %Y', range: start.beginning_of_month..Time.zone.now).count
    reads = StoryRead.by_story(options[:story_id]).group_by_month(:created_at, format: '%b %Y', range: start.beginning_of_month..Time.zone.now).count

    format_data(downloads, reads)
  end

  def group_by_lifetime
    start = Story.exclude_news.first.created_at.beginning_of_day
    downloads = StoryDownload.by_story(options[:story_id]).group_by_month(:created_at, format: '%b %Y', range: start..Time.zone.now).count
    reads = StoryRead.by_story(options[:story_id]).group_by_month(:created_at, format: '%b %Y', range: start..Time.zone.now).count

    format_data(downloads, reads)
  end

  def group_by_day
    start = options[:period].days.ago
    downloads = StoryDownload.by_story(options[:story_id]).group_by_day(:created_at, format: '%B %d, %Y', range: start.beginning_of_day..1.day.ago).count
    reads = StoryRead.by_story(options[:story_id]).group_by_day(:created_at, format: '%B %d, %Y', range: start.beginning_of_day..1.day.ago).count

    format_data(downloads, reads)
  end

  def format_data(downloads, reads)
    arr = []

    downloads.each do |key, value|
      arr.push(
        date: key,
        story_downloads: value,
        story_reads: reads[key]
      )
    end

    arr
  end
end
