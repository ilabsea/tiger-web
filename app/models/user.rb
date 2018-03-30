class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
   :trackable, :validatable

  enum role: [:admin, :reviewer, :publisher]
  after_initialize :set_default_role, :if => :new_record?

  scope :all_except, ->(user) { where.not(id: user) }

  def set_default_role
    self.role ||= :publisher
  end

  def self.normal_roles
    User.roles.except(:admin)
  end
end
