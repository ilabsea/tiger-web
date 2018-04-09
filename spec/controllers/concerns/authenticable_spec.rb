require 'rails_helper'

class Authentication < ActionController::Base
  include Authenticable
end

describe Authenticable, :type => :controller do
  let(:authentication) { Authentication.new }
  subject { authentication }

  describe "#current_user" do
    before do
      @user = FactoryBot.create :user
      request.headers["Authorization"] = @user.authentication_token
      authentication.stub(:request).and_return(request)
    end
    it "returns the user from the authorization header" do
      expect(authentication.current_user.authentication_token).to eq @user.authentication_token
    end
  end

  describe "#authenticate_with_token" do
    before do
      @user = FactoryBot.create :user
      authentication.stub(:current_user).and_return(nil)
      response.stub(:status).and_return(401)
      response.stub(:body).and_return({"errors" => "Not authenticated"}.to_json)
      authentication.stub(:response).and_return(response)
    end

    it "render a json error message" do
      json_response = JSON.parse response.body
      expect(json_response["errors"]).to eq "Not authenticated"
    end

    it { expect(response.status).to eq(401) }
  end
end
