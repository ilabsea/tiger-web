FactoryBot.define do
  factory :scene do
    name          { FFaker::Lorem.word }
    description   { FFaker::Lorem.paragraph }
    image         { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'scenes', 'scene1.jpeg'), 'image/jpeg') }
    audio         { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'scenes', 'scene1.mp3'), 'audio/mp3') }
    story
  end
end
