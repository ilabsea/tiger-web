class CreateUserAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :user_answers do |t|
      t.string  :user_uuid
      t.integer :question_id
      t.integer :choice_id

      t.timestamps null: false
    end
  end
end
