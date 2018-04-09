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

require 'rails_helper'

RSpec.describe User do
  it { should respond_to(:authentication_token) }
  it { should validate_uniqueness_of(:authentication_token)}

  describe "#regenerate_authentication_token!" do
    let(:user) { FactoryBot.create(:user, email: 'test@tiger.kape', password: 'password') }
    it "generates a unique token" do
      Devise.stub(:friendly_token).and_return("auniquetoken123")
      user.regenerate_authentication_token!
      expect(user.authentication_token).to eq "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryBot.create(:user, authentication_token: "auniquetoken123")
      user.regenerate_authentication_token!
      expect(user.authentication_token).not_to eq existing_user.authentication_token
    end
  end
end