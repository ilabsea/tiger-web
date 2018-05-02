class CreateSceneActions < ActiveRecord::Migration[5.1]
  def change
    create_table :scene_actions do |t|
      t.string :name
      t.integer :display_order
      t.integer :link_scene_id
      t.boolean :use_next, default: false
      t.integer :scene_id
      t.integer :story_id
    end
  end
end
