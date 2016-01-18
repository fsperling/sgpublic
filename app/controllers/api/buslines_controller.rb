class Api::BuslinesController < ApplicationController
  respond_to :json, :geojson

  def index
    @buslines = Busline.all
    respond_with @buslines
  end

  def show
    # TODO: well, busnumber should be unique, but each line has two directions
    @busline = Busline.where(busnumber: params[:id]).first
    @stops = [BusstopDetail.where(busstop_id: @busline.start_code).first]
    @stops.push(BusstopDetail.where(busstop_id: @busline.end_code).first)
    respond_with @busline, @stops
  end
end
