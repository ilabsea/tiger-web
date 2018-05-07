# frozen_string_literal: true

class StoryContentDuplicator
  attr_reader :master
  attr_reader :child

  def initialize(story_id)
    @master = find_master_story(story_id)
  end

  def dup
    clone_content

    true
  end

  private

  def clone_content
    clone_self
    clone_tags
    clone_scenes
    clone_scene_actions
  end

  def clone_self
    hash = clean_attributes(master)

    @child = Story.new(hash)
    @child.title = "#{master.title}-Copy-#{I18n.l(Time.now, format: :short)}"
    @child.image = File.open(master.image.file.file) if master.image.present?
    @child.save
  end

  def clone_tags
    master.tags.each do |tag|
      @child.tags << tag
    end
  end

  def clone_scenes
    master.scenes.each do |master_scene|
      hash = clean_attributes(master_scene)

      scene = @child.scenes.build(hash)
      scene.image = File.open(master_scene.image.file.file) if master_scene.image.present?
      scene.save
    end
  end

  def clone_scene_actions
    master.scenes.each do |master_scene|
      master_scene.scene_actions.each do |master_action|
        hash = clean_attributes(master_action)

        child_link_scene = @child.scenes.find_by(name: master_action.link_scene.name)
        child_scene = @child.scenes.find_by(name: master_scene.name)

        action = child_scene.scene_actions.new(hash)
        action.link_scene_id = child_link_scene.id
        action.story_id = @child.id
        action.save
      end
    end
  end

  def find_master_story(master_id)
    Story.includes(:scenes, :tags).find(master_id)
  end

  def clean_attributes(object)
    object.attributes.except(*except_attributes)
  end

  def except_attributes
    %w[
      id image story_id scene_id image status actived
      parent_id lft rgt depth children_count link_scene_id
      created_at updated_at
    ]
  end
end
