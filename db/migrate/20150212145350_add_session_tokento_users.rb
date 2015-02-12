class AddSessionTokentoUsers < ActiveRecord::Migration
  def change
    add_column :users, :session_token, :string, null: false

    add_index :users, :email, unique: true
    add_index :users, :session_token, unique: true
  end
end
