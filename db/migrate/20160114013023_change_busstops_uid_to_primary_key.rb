class ChangeBusstopsUidToPrimaryKey < ActiveRecord::Migration
  def change
    add_column :busstops, :id,  :primary_key
    remove_column :busstops, :uid
  end
end
