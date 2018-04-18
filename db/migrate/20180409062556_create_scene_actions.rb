class CreateSceneActions < ActiveRecord::Migration[5.1]
  def change
    create_table :scene_actions do |t|
      t.string :name
      t.integer :parent_id, null: true, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true
      t.integer :depth, null: false, default: 0
      t.integer :children_count, null: false, default: 0
      t.integer :scene_id
      t.integer :story_id
    end
  end
end
