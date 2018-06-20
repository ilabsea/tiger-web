class CreateQuizResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :quiz_responses do |t|
      t.integer :question_id
      t.integer :choice_id
      t.integer :story_read_id
    end
  end
end
