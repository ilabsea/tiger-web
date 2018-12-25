class AddColumnMessageToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :message, :text
  end
end
