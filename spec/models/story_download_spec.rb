# == Schema Information
#
# Table name: story_downloads
#
#  id          :integer          not null, primary key
#  story_id    :integer
#  device_type :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_type   :string(255)
#

require 'rails_helper'

RSpec.describe StoryDownload do
  it { is_expected.to belong_to(:story) }
end
