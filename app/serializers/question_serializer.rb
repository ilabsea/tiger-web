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
#


class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :label, :story_id, :display_order, :message

  has_many :choices
end
