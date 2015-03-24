class AddContactShareIndex < ActiveRecord::Migration
  def change
    add_index(:contact_shares, :contact_id)
    add_index(:contact_shares, :user_id)

  end
end
