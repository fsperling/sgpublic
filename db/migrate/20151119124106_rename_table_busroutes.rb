class RenameTableBusroutes < ActiveRecord::Migration
  def change
    rename_table :busroutes, :busstops
  end
end
