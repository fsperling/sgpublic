require 'geocoder'

class Api::GeocodeController < ApplicationController
  respond_to :json

  def index
    if params.key?(:zipcode)
      coords = Geocoder.new.location_by_zipcode(params[:zipcode])
    elsif params.key?(:busstation)
      coords = Geocoder.new.location_by_stopid(params[:busstation])
    end
    respond_with [ coords[:lat], coords[:long] ]
  end


end
