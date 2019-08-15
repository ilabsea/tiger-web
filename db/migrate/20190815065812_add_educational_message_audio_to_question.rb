class AddEducationalMessageAudioToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :educational_message_audio, :string
  end
end
