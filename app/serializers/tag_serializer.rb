# frozen_string_literal: true
# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  color      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class TagSerializer < ActiveModel::Serializer
  attributes :id, :title, :stories_count, :color

  def stories_count
    object.stories.published.length
  end
end
