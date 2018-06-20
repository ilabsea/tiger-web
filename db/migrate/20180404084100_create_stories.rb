class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :user_id
      t.string :status
      t.boolean :actived, default: true
      t.text :reason
      t.datetime :published_at
      t.string :author
      t.string :source_link

      t.timestamps null: false
    end
    add_index :stories, [:title, :user_id]
  end
end
