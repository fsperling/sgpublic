class RenameCodeColumnInTableBusstopDetails < ActiveRecord::Migration
  def change
    rename_column :busstop_details, :code, :busstop_id
  end
end
