class AddAudioToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :audio, :string
  end
end
