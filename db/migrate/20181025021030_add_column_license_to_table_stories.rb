class AddColumnLicenseToTableStories < ActiveRecord::Migration[5.1]
  def change
    add_column :stories, :license, :string
  end
end
