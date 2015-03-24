class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.string :status, null: false
      t.string :availability, null: false
      t.integer :user_id, null: false
      
      t.timestamps
    end
  end
end
