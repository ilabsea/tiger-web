# frozen_string_literal: true
# == Schema Information
#
# Table name: story_downloads
#
#  id          :integer          not null, primary key
#  story_id    :integer
#  device_type :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_type   :string(255)
#


class StoryDownloadSerializer < ActiveModel::Serializer
  attributes :id, :device_type, :story_id, :downloaded_at

  def downloaded_at
    object.created_at
  end
end
