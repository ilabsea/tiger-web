# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  label         :string(255)
#  story_id      :integer
#  display_order :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Question < ApplicationRecord
  belongs_to :story
  has_many :choices, dependent: :destroy

  accepts_nested_attributes_for :choices

  default_scope { order(display_order: :asc) }

  validates :label, presence: true

  ## Class Methods
  def self.update_order!(ids)
    super(ids, :display_order)
  end
end
