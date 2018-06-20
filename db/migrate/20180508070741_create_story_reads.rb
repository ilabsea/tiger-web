class CreateStoryReads < ActiveRecord::Migration[5.1]
  def change
    create_table :story_reads do |t|
      t.integer :story_id
      t.string :user_uuid

      t.timestamps null: false
    end
  end
end
