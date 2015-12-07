require 'lta_api'

class LtaApiWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    # remove old data first
    LtaApi.new.getDataFor('SBSTInfo')
    LtaApi.new.getDataFor('SMRTInfo')
    LtaApi.new.getDataFor('SBSTRoute')
    LtaApi.new.getDataFor('SMRTRoute')
    LtaApi.new.getDataFor('BusStopCode')
    # check and clean data for missing or wrong info
  end
end
