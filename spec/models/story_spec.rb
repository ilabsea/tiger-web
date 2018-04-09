# == Schema Information
#
# Table name: stories
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  image       :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Story do
  it { is_expected.to have_many(:story_tags).dependent(:destroy) }
  it { is_expected.to have_many(:tags).through(:story_tags) }
  it { is_expected.to have_many(:scenes).dependent(:destroy) }
end
