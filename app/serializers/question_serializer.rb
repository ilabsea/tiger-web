# frozen_string_literal: true
class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :label, :story_id, :display_order, :message, :audio

  has_many :choices

  def audio
    object.audio.try(:url)
  end
end
