require 'rails_helper'

describe Api::V1::SessionsController do

  describe "POST #create" do

   before(:each) do
    @user = FactoryBot.create(:user)
   end

    context "when the credentials are correct" do

      before(:each) do
        credentials = { email: @user.email, password: 'password' }
        post :create, params: { session: credentials }
      end

      it "returns the user record corresponding to the given credentials" do
        @user.reload
        json_response = JSON.parse response.body
        expect(json_response["authentication_token"]).to eq @user.authentication_token
      end

      it { expect(response.status).to eq(200) }
    end

    context "when the credentials are incorrect" do

      before(:each) do
        credentials = { email: @user.email, password: "invalidpassword" }
        post :create, params: { session: credentials }
      end

      it "returns a json with an error" do
        json_response = JSON.parse response.body
        expect(json_response["errors"]).to eql "Invalid email or password"
      end

      it { expect(response.status).to eq(422) }
    end
  end

  describe "DELETE #destroy" do

    before(:each) do
      @user = FactoryBot.create :user
      delete :destroy, params: {id: @user.authentication_token}
    end

    it { expect(response.status).to eq(204) }

  end
end
