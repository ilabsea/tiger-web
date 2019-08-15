# frozen_string_literal: true
class StoryDownloadSerializer < ActiveModel::Serializer
  attributes :id, :device_type, :story_id, :downloaded_at

  def downloaded_at
    object.created_at
  end
end
