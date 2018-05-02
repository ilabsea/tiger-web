require 'rails_helper'

RSpec.describe StoryContentDuplicator do
  describe '#dup' do
    let!(:parent_story) { create(:story, :with_scene_and_actions, :with_tags) }
    let!(:duplicator) { described_class.new(parent_story.id) }
    let!(:story) { duplicator.dup && duplicator.child }

    it 'clones parent story with different title' do
      expect(story.title).to eq "#{parent_story.title}-Copy-#{I18n.l(Time.now, format: :short)}"
    end

    it 'clones image' do
      expect(story.image.url).to include("image/#{story.id}/#{parent_story.image.filename}")
    end

    it 'clones story clone_tags' do
      expect(story.tags).to eq parent_story.tags
    end

    it 'clones story scenes' do
      expect(story.scenes.count).to eq parent_story.scenes.count
    end

    it 'clones story scene actions' do
      expect(story.scene_actions.count).to eq parent_story.scene_actions.count
    end
  end
end
