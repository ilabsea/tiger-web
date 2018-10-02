require 'rails_helper'

RSpec.describe StoryChart do
  describe '#data' do
    let!(:story1) {create(:story, title: 'story1', status: 'published', created_at: 18.months.ago)}
    let!(:story2) {create(:story, title: 'story2', status: 'published', created_at: 1.year.ago)}

    before(:each) do
      allow(Time).to receive(:now).and_return DateTime.new(2018, 5, 31)

      (1..18).each do |i|
        story1.story_downloads.create(created_at: (i).days.ago)
        story1.story_reads.create(created_at: (i).days.ago)
      end
    end

    context 'when has params and period_unit is day, it returns data group by day' do
      let(:from) { 7.days.ago.to_date.beginning_of_day }
      let(:to) { Time.now.to_date.at_end_of_day }
      let(:data) { StoryChart.chart_data(from, to) }

      it { expect(data.length).to eq(8) }
      it { expect(data.first[:story_reads]).to eq(1) }
      it { expect(data.first[:story_downloads]).to eq(1) }
      it { expect(data.last[:story_downloads]).to eq(0) }
      it { expect(data.last[:story_downloads]).to eq(0) }
    end
  end
end
