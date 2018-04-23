# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :integer
#  deleted_at             :datetime
#  authentication_token   :string(255)      default("")
#  token_expired_date     :datetime
#

FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "admin-#{n}@ilabsea.org"}
    password  "password"
    role :admin
  end

  factory :user do
    sequence(:email) {|n| "user-#{n}@tiger.kape"}
    password 'password'
    role :publisher
  end

end
