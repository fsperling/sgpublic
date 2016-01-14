class ChangeBuslinesUidToPrimaryKey < ActiveRecord::Migration
  def change
    add_column :buslines, :id,  :primary_key
    remove_column :buslines, :uid
  end
end
