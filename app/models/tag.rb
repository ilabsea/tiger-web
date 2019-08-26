# frozen_string_literal: true
# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  color      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  has_many :story_tags, dependent: :destroy
  has_many :stories, through: :story_tags

  strip_attributes only: [:title]

  validates :title, presence: true

  # callback
  before_save :set_color

  private

  def set_color
    self.color = "##{format('%06x', (rand * 0xffffff))}"
  end
end
