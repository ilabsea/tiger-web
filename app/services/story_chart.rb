# frozen_string_literal: true

# Charts & Graphs
# http://railscasts.com/episodes/223-charts-graphs-revised

class StoryChart
  attr_reader :options

  def initialize(options = {})
    @options = options
  end

  def data
    options[:period] = if options[:period].present?
                         options[:period].to_i.send(options[:period_unit]).ago
                       else
                         7.days.ago
                       end

    story_downloads = filter_story_download(options)
    story_reads = filter_story_read(options)

    (options[:period].to_date..1.day.ago.to_date).map do |date|
      {
        date: I18n.l(date, format: :long),
        story_downloads: story_downloads[date] || 0,
        story_reads: story_reads[date] || 0
      }
    end
  end

  # https://rubyplus.com/articles/3311-Group-By-Month-in-Rails-5
  # https://stackoverflow.com/questions/12526161/group-records-by-both-month-and-year-in-rails
  def filter_story_download(options = {})
    StoryDownload.filter(options)
  end

  def filter_story_read(options = {})
    StoryRead.filter(options)
  end
end
