require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "confirmation_instructions" do

    let(:user) { FactoryBot.create(:user) }
    let(:mail) { UserMailer.confirmation_instructions(user, user.confirmation_token, {}) }

    before(:each) do
     user.confirm
    end

    it "renders the headers" do
      expect(mail.subject).to eq("Tiger Sign Up Confirmation")
      expect(mail.to).to eq([user.email])
      # expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Welcome")
    end
  end

end
