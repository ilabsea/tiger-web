class CreateChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :choices do |t|
      t.string  :label
      t.boolean :answered, default: false
      t.integer :question_id

      t.timestamps null: false
    end
  end
end
