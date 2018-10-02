# frozen_string_literal: true

class StoryChart
  def self.chart_of(options = {})
    tag_id = options[:tag_id] || nil
    from = options[:from].to_date.beginning_of_day
    to = options[:to].to_date.at_end_of_day

    chart_data(from, to, tag_id)
  end

  def self.chart_data(from, to, tag_id = nil)
    datas = []

    downloads = StoryDownload.chart_of(from, to, tag_id)
    reads = StoryRead.chart_of(from, to, tag_id)

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
