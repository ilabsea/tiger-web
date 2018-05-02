FactoryBot.define do
  factory :scene_action do
    name          { FFaker::Lorem.word }
    link_scene_id { create(:scene).id }
    scene
    story
  end
end
