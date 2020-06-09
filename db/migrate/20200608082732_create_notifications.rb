class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string   :uuid
      t.string   :title
      t.text     :body
      t.integer  :creator_id
      t.integer  :success_count
      t.integer  :failure_count

      t.timestamps
    end
  end
end
