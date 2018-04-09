require 'rails_helper'

RSpec.describe SceneAction do
  it { is_expected.to belong_to(:scene) }
  it { is_expected.to validate_presence_of(:name) }
end
