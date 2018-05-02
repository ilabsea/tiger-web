# frozen_string_literal: true

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :label, :story_id

  has_many :choices
end
