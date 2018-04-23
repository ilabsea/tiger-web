class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :description
      t.string :image
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :stories, [:title, :user_id]
  end
end
