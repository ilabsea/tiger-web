require 'rails_helper'

RSpec.describe StoryDownload do
  it { is_expected.to belong_to(:story) }
end
