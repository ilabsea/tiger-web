require 'rails_helper'

RSpec.describe StoryChart do
  describe '#data' do
    let!(:story1) {create(:story, title: 'story1', status: 'published', created_at: 18.months.ago)}
    let!(:story2) {create(:story, title: 'story2', status: 'published', created_at: 1.year.ago)}

    let(:storyChart) { StoryChart.new() }
    let(:data) { storyChart.data }
    let(:total_downloads) { data.map { |d| d[:story_downloads] }.sum }
    let(:total_reads) { data.map { |d| d[:story_reads] }.sum }

    before(:each) do
      allow(Time).to receive(:now).and_return DateTime.new(2018, 5, 31)

      (1..18).each do |i|
        story1.story_downloads.create(created_at: (i).months.ago)
        story1.story_downloads.create(created_at: (i).days.ago)
      end

      (1..12).each do |i|
        story2.story_downloads.create(created_at: (i).months.ago)
        story2.story_downloads.create(created_at: (i).days.ago)
      end

      (1..15).each do |i|
        story1.story_reads.create(created_at: (i).months.ago)
        story1.story_reads.create(created_at: (i).days.ago)
      end

      (1..8).each do |i|
        story2.story_reads.create(created_at: (i).months.ago)
        story2.story_reads.create(created_at: (i).days.ago)
      end
    end

    context 'when no params, it returns story downloads and reads group by day within last 7 days' do
      it { expect(data.length).to eq(7) }
      it { expect(total_downloads).to eq(14) }
      it { expect(total_reads).to eq(14) }
    end

    context 'when has params and period_unit is day, it returns data group by day' do
      let(:storyChart) { StoryChart.new({period: 30, period_unit: 'day'}) }

      it { expect(data.length).to eq(30) }
      it { expect(total_downloads).to eq(30) }
      it { expect(total_reads).to eq(23) }
    end

    context 'when has params and period_unit is months, it returns data group by month' do
      let(:storyChart) { StoryChart.new({period: 12, period_unit: 'months'}) }

      it { expect(data.length).to eq(12) }
      it { expect(total_downloads).to eq(24) }
      it { expect(total_reads).to eq(20) }
    end

    context 'when has params and period_unit is lifetime, it returns data group by month' do
      let(:storyChart) { StoryChart.new({period: '', period_unit: 'lifetime'}) }

      it { expect(data.length).to eq(19) }
      it { expect(total_downloads).to eq(60) }
      it { expect(total_reads).to eq(46) }
    end

    context 'when has params and period_unit is custom, it returns data group by day within from and to' do
      let(:storyChart) { StoryChart.new({period: '', period_unit: 'custom', from: '2018-05-01', to: '2018-05-31'}) }

      it { expect(data.length).to eq(31) }
      it { expect(total_downloads).to eq(30) }
      it { expect(total_reads).to eq(23) }
    end

    context 'when has params story_id is 1, it returns data group by day within last 7 days of story1' do
      let(:storyChart) { StoryChart.new({story_id: story1.id}) }

      it { expect(data.length).to eq(7) }
      it { expect(total_downloads).to eq(7) }
      it { expect(total_reads).to eq(7) }
    end
  end
end
