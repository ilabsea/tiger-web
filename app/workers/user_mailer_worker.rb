class UserMailerWorker
  include Sidekiq::Worker
  # sidekiq_options queue: :mailer

  def perform(user_id, *args)
    user = User.find(user_id)
    UserMailer.confirmation_instructions(user, user.confirmation_token, opts={}).deliver_now
  end
end
