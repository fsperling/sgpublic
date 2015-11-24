class ChangeBusnumberToVarchar < ActiveRecord::Migration
  def change
    change_column :buslines, :busnumber,  :string
  end
end
