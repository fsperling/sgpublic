class CreateBusroutes < ActiveRecord::Migration
  def change
    create_table :busroutes, {id: false} do |t|
      t.integer :uid
      t.string  :busnumber
      t.integer :direction
      t.string :type
      t.integer :start_code
      t.integer :end_code
      t.string :freq_am_peak
      t.string :freq_am_off
      t.string :freq_pm_peak
      t.string :freq_pm_off
      t.integer :loop_code

      t.timestamps
    end
  end
end
