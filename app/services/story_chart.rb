# frozen_string_literal: true

class StoryChart
  def self.chart_of(options = {})
    tag_id = options[:tag_id] || nil
    from = options[:from].to_date.beginning_of_day
    to = options[:to].to_date.at_end_of_day
    user_type = options[:user_type] || nil

    chart_data(from, to, tag_id: tag_id, user_type: user_type)
  end

  def self.chart_data(from, to, options = {})
    datas = []
    downloads = StoryDownload.chart_of(from, to, options)
    reads = StoryRead.chart_of(from, to, options)

    downloads.each do |key, value|
      datas.push(
        date: key,
        story_downloads: value,
        story_reads: reads[key]
      )
    end

    datas
  end
end
