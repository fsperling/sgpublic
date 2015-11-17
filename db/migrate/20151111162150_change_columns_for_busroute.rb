class ChangeColumnsForBusroute < ActiveRecord::Migration
  def change
      remove_column :busroutes, :start_code
      remove_column :busroutes, :end_code
      remove_column :busroutes, :freq_pm_off
      remove_column :busroutes, :freq_am_off
      remove_column :busroutes, :freq_pm_peak
      remove_column :busroutes, :freq_am_peak
      remove_column :busroutes, :loop_code
      remove_column :busroutes, :type

      add_column :busroutes, :stop_number, :integer
      add_column :busroutes, :busstation_id, :integer
  end
end
