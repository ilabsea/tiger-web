require 'rails_helper'

RSpec.describe Scene do
  it { is_expected.to have_many(:scene_actions) }
  it { is_expected.to belong_to(:story) }
  it { is_expected.to validate_presence_of(:name)}
  it { is_expected.to validate_presence_of(:description)}
end
