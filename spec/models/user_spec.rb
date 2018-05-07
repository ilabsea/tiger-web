require 'rails_helper'

RSpec.describe User do
  it { is_expected.to respond_to(:authentication_token) }
  it { is_expected.to validate_uniqueness_of(:authentication_token) }
  it { is_expected.to have_many(:stories).dependent(:destroy) }

  describe "#regenerate_authentication_token" do
    let(:user) { FactoryBot.create(:user, email: 'test@tiger.kape', password: 'password') }
    it "generates a unique token" do
      Devise.stub(:friendly_token).and_return("auniquetoken123")
      user.regenerate_authentication_token
      expect(user.authentication_token).to eq "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryBot.create(:user, authentication_token: "auniquetoken123")
      user.regenerate_authentication_token
      expect(user.authentication_token).not_to eq existing_user.authentication_token
    end
  end
end
