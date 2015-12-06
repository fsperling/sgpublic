class RenameColumnOfBusstops < ActiveRecord::Migration
  def change
    rename_column :busstops, :busstation_id, :busstop_id
  end
end
