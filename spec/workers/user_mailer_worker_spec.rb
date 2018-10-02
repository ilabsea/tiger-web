require 'rails_helper'
RSpec.describe UserMailerWorker, type: :worker do

  let(:user) { FactoryBot.create(:user, email: 'test@tiger.kape', password: 'password') }

  before(:each) do
    user.confirm
  end

  it { expect{UserMailerWorker.perform_async(user.id)}.to change(UserMailerWorker.jobs, :size).by(1) }

end
