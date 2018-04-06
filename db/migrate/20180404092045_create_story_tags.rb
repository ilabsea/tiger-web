class CreateStoryTags < ActiveRecord::Migration[5.1]
  def change
    create_table :story_tags do |t|
      t.references :story, index: true
      t.references :tag, index: true

      t.timestamps null: false
    end
    add_foreign_key :story_tags, :stories
    add_foreign_key :story_tags, :tags

  end
end
