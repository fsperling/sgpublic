class RenameTypeColumnOfBusline < ActiveRecord::Migration
  def change
    rename_column :buslines, :type, :type_of_bus
  end
end
