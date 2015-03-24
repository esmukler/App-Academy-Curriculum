class ChangePostColumn < ActiveRecord::Migration
  def change
    change_column(:posts, :sub_id, :integer)
  end
end
