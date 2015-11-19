require 'rest-client'
require 'json'
require 'lta_api'

class BusstopsController < ApplicationController
  def generate_info
    LtaApi.new.getDataFor("SBSTInfo")
    LtaApi.new.getDataFor("SMRTInfo")

   # feedback to user? 
    flash[:success] = "Import of busrouteinfo complete"
  end

  def generate_route
    LtaApi.new.getDataFor("SBSTRoute")
    LtaApi.new.getDataFor("SMRTRoute")
  end

  def list
    @allstops = Busstop.all
  end

end
