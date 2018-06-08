class CreateStoryResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :story_responses do |t|
      t.integer :scene_id
      t.integer :scene_action_id
      t.integer :story_read_id
    end
  end
end
