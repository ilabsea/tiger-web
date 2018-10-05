class AddUserTypeToStoryDownloads < ActiveRecord::Migration[5.1]
  def change
    add_column :story_downloads, :user_type, :string
  end
end
