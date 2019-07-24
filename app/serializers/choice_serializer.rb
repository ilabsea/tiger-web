# frozen_string_literal: true
# == Schema Information
#
# Table name: choices
#
#  id          :integer          not null, primary key
#  label       :string(255)
#  answered    :boolean          default(FALSE)
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


class ChoiceSerializer < ActiveModel::Serializer
  attributes :id, :label, :answered, :question_id
end
