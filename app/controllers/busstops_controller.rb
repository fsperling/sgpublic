class BusstopsController < ApplicationController
  def import_lta_data
    LtaApiWorker.perform_async
    render text: 'Import of LTA data triggered.'
  end
end
