class ChangeVisitColumnType < ActiveRecord::Migration
  def change
    add_column :visits, :temp_visited_url_id, :integer
    Visit.all.each do |visit|
      visit.update!( temp_visited_url_id: visit.visited_url_id.to_i)
    end
    remove_column :visits, :visited_url_id
    rename_column :visits, :temp_visited_url_id, :visited_url_id
  end
end
