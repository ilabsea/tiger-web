require 'rails_helper'

RSpec.describe SceneAction do
  it { is_expected.to belong_to(:scene) }
  it { is_expected.to belong_to(:story) }
  it { is_expected.to belong_to(:link_scene).class_name('Scene').with_foreign_key(:link_scene_id) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:story_id) }
end
