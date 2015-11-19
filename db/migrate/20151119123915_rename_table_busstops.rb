class RenameTableBusstops < ActiveRecord::Migration
  def change
    rename_table :busstops, :busstop_details
  end
end
