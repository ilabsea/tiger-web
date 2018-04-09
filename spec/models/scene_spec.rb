require 'rails_helper'

RSpec.describe Scene do
  it { is_expected.to have_many(:scene_actions) }
  it { is_expected.to belong_to(:story) }
end
