# == Schema Information
#
# Table name: scenes
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  description         :text(65535)
#  image               :string(255)
#  parent_id           :integer
#  lft                 :integer          not null
#  rgt                 :integer          not null
#  story_id            :integer
#  visible_name        :boolean          default(TRUE)
#  image_as_background :boolean          default(FALSE)
#  is_end              :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  audio               :string(255)
#

require 'rails_helper'

RSpec.describe Scene do
  let!(:scene) { create(:scene) }

  it { is_expected.to have_many(:scene_actions) }
  it { is_expected.to belong_to(:story) }
  it { is_expected.to validate_presence_of(:name)}
  it { is_expected.to validate_presence_of(:description)}

  it 'has has image' do
    expect(scene.image.current_path).to be_truthy
  end

  it 'has has audio' do
    expect(scene.audio.current_path).to be_truthy
  end

  it "remove related attachement" do
    scene.remove_related_attachements
    expect(scene.audio.current_path).to be_nil
  end
end
