# == Schema Information
#
# Table name: scenes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  image       :string(255)
#  story_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Scene do
  it { is_expected.to have_many(:scene_actions) }
  it { is_expected.to belong_to(:story) }
  it { is_expected.to validate_presence_of(:name)}
  it { is_expected.to validate_presence_of(:description)}
end
