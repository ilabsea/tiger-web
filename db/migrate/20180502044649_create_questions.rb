class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string  :label
      t.integer :story_id
      t.integer :display_order

      t.timestamps null: false
    end
  end
end
