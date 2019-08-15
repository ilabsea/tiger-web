FactoryBot.define do
  factory :question do
    label          { FFaker::Lorem.phrase }
    audio          { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'questions', 'question1.mp3'), 'audio/mp3') }
    story

    trait :with_choices do
      transient do
        choices_count 3
      end

      after(:create) do |question, evaluator|
        create_list(:choice, evaluator.choices_count, question: question)
        question.choices.last.update_attribute(:answered, true)
      end
    end
  end
end
