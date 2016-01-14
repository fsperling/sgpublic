class ChangeBusstopdetailsUidToPrimaryKey < ActiveRecord::Migration
  def change
    add_column :busstop_details, :id,  :primary_key
    remove_column :busstop_details, :uid
  end
end
