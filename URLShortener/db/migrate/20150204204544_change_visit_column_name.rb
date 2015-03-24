class ChangeVisitColumnName < ActiveRecord::Migration
  def change
    rename_column :visits, :visited_url, :visited_url_id


  end
end
