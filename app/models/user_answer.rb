# frozen_string_literal: true
# == Schema Information
#
# Table name: user_answers
#
#  id          :integer          not null, primary key
#  user_uuid   :string(255)
#  question_id :integer
#  choice_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :choice

  validates :user_uuid, presence: true
end
