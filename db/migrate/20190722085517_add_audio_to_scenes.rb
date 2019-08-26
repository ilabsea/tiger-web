class AddAudioToScenes < ActiveRecord::Migration[5.1]
  def change
    add_column :scenes, :audio, :string
  end
end
