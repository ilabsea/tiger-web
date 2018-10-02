# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def confirmation_instructions(user, token, opts={})
    @user = user
    @token = token

    mail to: user.email, subject: 'Tiger Sign Up Confirmation'
  end
end
