require 'lta_api'

class BusstopsController < ApplicationController
  def generate
    LtaApi.new.getDataFor("BusStopCode")

   # feedback to user? 
    flash[:success] = "Import of busstops complete"
  end

  def list
    @allstops = Busstop.all
  end
end
