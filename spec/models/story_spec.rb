require 'rails_helper'

RSpec.describe Story do
  it { is_expected.to have_many(:story_tags).dependent(:destroy) }
  it { is_expected.to have_many(:tags).through(:story_tags) }
  it { is_expected.to have_many(:scenes).dependent(:destroy) }
end
