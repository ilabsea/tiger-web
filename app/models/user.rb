class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
   :trackable, :validatable

  enum role: [:admin, :publisher]
  after_initialize :set_default_role, :if => :new_record?

  scope :all_except, ->(user) { where.not(id: user) }

  self.per_page = 15

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
    self.deleted_at ? 'inactive' : 'active'
  end

end
