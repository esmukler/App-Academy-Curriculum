class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.timestamps

      t.string :title, null: false
      t.text   :description, null: false
      t.integer :moderator_id, null: false
    end
    add_index :subs, :moderator_id  
  end
end
