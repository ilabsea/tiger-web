class CreateScenes < ActiveRecord::Migration[5.1]
  def change
    create_table :scenes do |t|
      t.string :name
      t.text   :description
      t.string :image
      t.integer :parent_id, null: true, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true
      t.integer :story_id
      t.boolean :visible_name, default: true
      t.boolean :image_as_background, default: false

      t.timestamps null: false
    end
  end
end
