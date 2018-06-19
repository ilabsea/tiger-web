FactoryBot.define do
  factory :story do
    title       { FFaker::Book.title }
    description { FFaker::Book.description }
    status      'new'
    image       { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'stories', 'story1.png'), 'image/png') }
    author      { FFaker::Name.name }
    user

    trait :with_scene_and_actions do
      transient do
        scenes_count 3
      end

      after(:create) do |story, evaluator|
        create_list(:scene, evaluator.scenes_count, story: story)

        (evaluator.scenes_count - 1).times do |index|
          create(:scene_action, scene: story.scenes[index], story: story, link_scene_id: story.scenes[index+1].id)
        end
      end
    end

    trait :with_questions_and_choices do
      transient do
        questions_count 3
      end

      after(:create) do |story, evaluator|
        create_list(:question, evaluator.questions_count, :with_choices, story: story)
      end
    end

    trait :with_tags do
      transient do
        tags_count 2
      end

      after(:create) do |story, evaluator|
        evaluator.tags_count.times do |index|
          story.tags << create(:tag)
        end
      end
    end
  end
end
