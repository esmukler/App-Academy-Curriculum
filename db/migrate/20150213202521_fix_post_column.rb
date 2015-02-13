class FixPostColumn < ActiveRecord::Migration
  def change
    remove_column(:posts, :sub_id)
    add_column(:posts, :sub_id, :integer)
  end
end
