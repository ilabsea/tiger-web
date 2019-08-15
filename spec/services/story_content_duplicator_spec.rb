require 'rails_helper'

RSpec.describe StoryContentDuplicator do
  describe '#dup' do
    let!(:parent_story) { create(:story, :with_scene_and_actions, :with_questions_and_choices, :with_tags) }
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

    it "clones story scene's audio" do
      expect(File.basename(story.scenes.first.audio.path)).to eq File.basename(parent_story.scenes.first.audio.path)
    end

    it 'clones story scene actions' do
      expect(story.scene_actions.count).to eq parent_story.scene_actions.count
    end

    it 'clones story questions' do
      expect(story.questions.count).to eq parent_story.questions.count
    end

    it "clones story question's audio" do
      expect(File.basename(story.questions.first.audio.path)).to eq File.basename(parent_story.questions.first.audio.path)
    end

    it "clones story question's educational message audio" do
      expect(File.basename(story.questions.first.educational_message_audio.path)).to eq File.basename(parent_story.questions.first.educational_message_audio.path)
    end

    it 'clones story question choices' do
      expect(story.questions[0].choices.count).to eq parent_story.questions[0].choices.count
    end
  end
end
