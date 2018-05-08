class CreateStoryDownloads < ActiveRecord::Migration[5.1]
  def change
    create_table :story_downloads do |t|
      t.integer :story_id
      t.string :device_type

      t.timestamps null: false
    end
  end
end
