# frozen_string_literal: true

class StoryChart
  attr_reader :options

  def initialize(options = {})
    @options = options
    @options[:period] ||= 7
    @options[:period_unit] ||= 'days'
  end

  def data
    return group_by_month if %w[month months].include?(options[:period_unit].downcase)
    return group_by_lifetime if options[:period_unit].casecmp('lifetime').zero?
    return group_by_custom if options[:period_unit].casecmp('custom').zero?

    group_by_day
  end

  private

  def group_by_month
    from = options[:period].to_i.months.ago.beginning_of_month
    to = Time.zone.now.beginning_of_month - 1.day

    data_by_month(from, to)
  end

  def group_by_lifetime
    from = Story.exclude_news.first.created_at.beginning_of_day
    from = Story.find(options[:story_id]).created_at.beginning_of_day if options[:story_id].present?
    to = Time.zone.now

    data_by_month(from, to)
  end

  def group_by_custom
    from = options[:from].to_date.beginning_of_day
    to = options[:to].to_date.at_end_of_day

    data_by_day(from, to)
  end

  def group_by_day
    from = options[:period].to_i.days.ago.beginning_of_day
    to = 1.day.ago.at_end_of_day

    data_by_day(from, to)
  end

  def data_by_month(from, to)
    downloads = StoryDownload.by_story(options[:story_id]).group_by_month(:created_at, format: '%b %Y', range: from..to).count
    reads = StoryRead.by_story(options[:story_id]).group_by_month(:created_at, format: '%b %Y', range: from..to).count

    format_data(downloads, reads)
  end

  def data_by_day(from, to)
    downloads = StoryDownload.by_story(options[:story_id]).group_by_day(:created_at, format: '%B %d, %Y', range: from..to).count
    reads = StoryRead.by_story(options[:story_id]).group_by_day(:created_at, format: '%B %d, %Y', range: from..to).count

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
