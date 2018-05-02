# == Schema Information
#
# Table name: scene_actions
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  parent_id      :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#  scene_id       :integer
#

require 'rails_helper'

RSpec.describe SceneAction do
  it { is_expected.to belong_to(:scene) }
  it { is_expected.to belong_to(:story) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:scene_id) }
  it { is_expected.to validate_presence_of(:story_id) }
end
