require 'rails_helper'

RSpec.describe StoryRead do
  it { is_expected.to belong_to(:story) }
end
