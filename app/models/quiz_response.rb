# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_responses
#
#  id            :integer          not null, primary key
#  question_id   :integer
#  choice_id     :integer
#  story_read_id :integer
#

class QuizResponse < ApplicationRecord
  belongs_to :story_read
end
