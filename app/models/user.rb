# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :integer
#  deleted_at             :datetime
#  authentication_token   :string(255)      default("")
#  token_expired_date     :datetime
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable

  enum role: %i[admin publisher]
  after_initialize :set_default_role, if: :new_record?

  scope :all_except, ->(user) { where.not(id: user).order('updated_at desc') }

  before_create :regenerate_authentication_token!

  validates :authentication_token, uniqueness: true

  before_create :regenerate_authentication_token!

  validates :authentication_token, uniqueness: true

  def set_default_role
    self.role ||= :publisher
  end

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  def active_for_authentication?
    super && !deleted_at?
  end

  def status
    deleted_at ? 'inactive' : 'active'
  end

  def regenerate_authentication_token!
    self.authentication_token = Devise.friendly_token
    self.token_expired_date = Time.zone.now
  end

  def regenerate_authentication_token!
    self.authentication_token = Devise.friendly_token
    self.token_expired_date = Time.zone.now
  end

end
