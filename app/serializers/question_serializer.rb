# frozen_string_literal: true
class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :label, :story_id, :display_order, :message, :audio, :educational_message_audio

  has_many :choices

  def audio
    object.audio.try(:url)
  end

  def educational_message_audio
    object.educational_message_audio.try(:url)
  end
end
