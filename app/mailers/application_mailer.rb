# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('SETTINGS__SMTP__DEFAULT_FROM') {'from@example.com'}
  layout 'mailer'
end
