class AddAuthenticationTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :authentication_token, :string, default: ""
    add_column :users, :token_expired_date, :datetime
    add_index :users, :authentication_token, unique: true
  end
end
