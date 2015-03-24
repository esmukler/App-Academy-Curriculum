class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.integer :author_id
      t.text    :title

      t.timestamps
    end

    add_index(:polls, :author_id)
  end
end
