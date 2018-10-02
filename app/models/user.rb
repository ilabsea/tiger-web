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
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable

  enum role: %i[admin publisher]
  after_initialize :set_default_role, if: :new_record?
  after_initialize :set_default_status, if: :new_record?

  scope :all_except, ->(user) { where.not(id: user).order('updated_at desc') }

  has_many :stories, dependent: :destroy

  before_create :regenerate_authentication_token

  validates :authentication_token, uniqueness: true

  def set_default_role
    self.role ||= :publisher
  end

  def set_default_status
    self.status ||= :pending
  end

  def soft_delete
    update_attributes(deleted_at: Time.current, status: :inactived)
  end

  def active_for_authentication?
    super && (!deleted_at? && status != 'pending')
  end

  def regenerate_authentication_token
    self.authentication_token = Devise.friendly_token
    self.token_expired_date = ENV['TOKEN_EXPIRED_IN_MONTH'].to_i.month.from_now
  end

  def self.filter(params)
    relation = all
    relation = relation.where(status: params[:status]) if params[:status].present?
    relation
  end
end
