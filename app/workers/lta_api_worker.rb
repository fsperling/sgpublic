require 'lta_api'
require 'lta_data'

class LtaApiWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
#    LtaApi.new.get_data_for('SBSTInfo')
#    LtaApi.new.get_data_for('SMRTInfo')
#    LtaApi.new.get_data_for('SBSTRoute')
#    LtaApi.new.get_data_for('SMRTRoute')
    LtaApi.new.get_data_for('BusStopCode')

    LtaData.new.check_data
  end
end
