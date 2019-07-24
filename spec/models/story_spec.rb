# == Schema Information
#
# Table name: stories
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :text(65535)
#  image        :string(255)
#  user_id      :integer
#  status       :string(255)
#  actived      :boolean          default(TRUE)
#  reason       :text(65535)
#  published_at :datetime
#  author       :string(255)
#  source_link  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  license      :string(255)
#

require 'rails_helper'

RSpec.describe Story do
  it { is_expected.to have_many(:story_tags).dependent(:destroy) }
  it { is_expected.to have_many(:tags).through(:story_tags) }
  it { is_expected.to have_many(:scenes).dependent(:destroy) }
  it { is_expected.to have_many(:questions).dependent(:destroy) }
  it { is_expected.to have_many(:story_downloads).dependent(:destroy) }
  it { is_expected.to have_many(:story_reads).dependent(:destroy) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to accept_nested_attributes_for(:tags) }
  it { is_expected.to validate_presence_of(:title)}
  it { is_expected.to validate_presence_of(:license)}
  it { is_expected.to validate_uniqueness_of(:title).case_insensitive }

  it 'before_validation, sets default status as new' do
    story = Story.create
    expect(story.status).to eq 'new'
  end

  describe '#validate_inclusion_of status' do
    let!(:story) { create(:story) }

    it 'accepts new' do
      story.status = 'new'
      expect(story.save).to eq true
    end

    it 'accepts published' do
      story.status = 'published'
      expect(story.save).to eq true
    end

    it 'accepts rejected' do
      story.status = 'rejected'
      expect(story.save).to eq true
    end

    it 'accepts archived' do
      story.status = 'archived'
      expect(story.save).to eq true
    end

    it 'does not accepts other' do
      story.status = 'other'
      expect(story.save).to eq false
    end
  end

  describe '#tags_attributes' do
    let!(:story) { create(:story) }
    let!(:tag)   { create(:tag, title: 'tag1') }

    it 'creates new tag' do
      params = { tags_attributes: [ {title: 'tag2'} ] }
      story.update_attributes(params)

      expect(Tag.count).to eq(2)
    end

    it 'uses existed tag' do
      params = { tags_attributes: [ {title: 'tag1'} ] }
      story.update_attributes(params)

      expect(Tag.count).to eq(1)
    end

    it 'does not destory tag' do
      story.tags << tag
      params = { tags_attributes: [ {id: tag.id, title: 'tag1', _destroy: true} ] }
      story.update_attributes(params)

      expect(Tag.count).to eq(1)
    end

    it 'destory story_tags' do
      story.tags << tag
      params = { tags_attributes: [ {id: tag.id, title: 'tag1', _destroy: true} ] }
      story.update_attributes(params)
      story.reload

      expect(story.story_tags.count).to eq(0)
      expect(story.tags.count).to eq(0)
    end
  end
end
