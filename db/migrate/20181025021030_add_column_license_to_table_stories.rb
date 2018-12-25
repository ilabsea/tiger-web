class AddColumnLicenseToTableStories < ActiveRecord::Migration[5.1]
  def change
    add_column :stories, :license, :string

    Story.update_all(license: Story.licenses.first)
  end
end
