class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name,       null: false
      t.integer :band_id,   null: false
      t.string :setting,    null: false

      t.timestamps
    end
  end
end
