# frozen_string_literal: true
class ChoiceSerializer < ActiveModel::Serializer
  attributes :id, :label, :answered, :question_id
end
