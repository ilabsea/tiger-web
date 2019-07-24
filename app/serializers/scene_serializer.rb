# frozen_string_literal: true
# == Schema Information
#
# Table name: scenes
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  description         :text(65535)
#  image               :string(255)
#  parent_id           :integer
#  lft                 :integer          not null
#  rgt                 :integer          not null
#  story_id            :integer
#  visible_name        :boolean          default(TRUE)
#  image_as_background :boolean          default(FALSE)
#  is_end              :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  audio               :string(255)
#


class SceneSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :story_id, :image, :is_end,
             :visible_name, :image_as_background, :audio

  has_many :scene_actions

  def image
    object.image.try(:url)
  end

  def audio
    object.audio.try(:url)
  end
end
