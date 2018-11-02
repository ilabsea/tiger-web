# frozen_string_literal: true

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :label, :story_id, :display_order, :message

  has_many :choices
end
