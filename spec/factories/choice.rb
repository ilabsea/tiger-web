FactoryBot.define do
  factory :choice do
    label          { FFaker::Lorem.word }
    answered       false
    question
  end
end
