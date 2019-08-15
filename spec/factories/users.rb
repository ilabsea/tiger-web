FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "admin-#{n}@ilabsea.org"}
    password  'password'
    status 'actived'
    role :admin
  end

  factory :user do
    sequence(:email) {|n| "user-#{n}@tiger.kape"}
    password 'password'
    status 'actived'
    role :publisher
  end
end
