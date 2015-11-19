class AddIndex < ActiveRecord::Migration
  def change
    add_index :buslines, :busnumber
    add_index :busstops, :busnumber
    add_index :busstops, :busstation_id
  end
end
