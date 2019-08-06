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
#  message       :text(65535)
#  audio         :string(255)
#

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :label, :story_id, :display_order, :message, :audio

  has_many :choices

  def audio
    object.audio.try(:url)
  end
end
