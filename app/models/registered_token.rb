# frozen_string_literal: true

class RegisteredToken < ApplicationRecord
  validates :token, presence: true
end
