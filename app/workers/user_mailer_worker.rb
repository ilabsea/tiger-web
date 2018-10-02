# frozen_string_literal: true

class UserMailerWorker
  include Sidekiq::Worker

  def perform(user_id, *_args)
    user = User.find(user_id)
    UserMailer.confirmation_instructions(user, user.confirmation_token, {}).deliver_now
  end
end
