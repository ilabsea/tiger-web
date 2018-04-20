class CreateScenes < ActiveRecord::Migration[5.1]
  def change
    create_table :scenes do |t|
      t.string :name
      t.text   :description
      t.string :image
      t.integer :story_id

      t.timestamps null: false
    end
  end
end
