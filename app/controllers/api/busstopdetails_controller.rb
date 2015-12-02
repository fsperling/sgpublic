class Api::BusstopdetailsController < ApplicationController
  respond_to :json, :geojson

  def index
    if params[:busline_id]
      @busstops = Busline.where(busnumber: params[:busline_id]).first.busstops
      @coordinates = Busline.where(busnumber: params[:busline_id]).first.get_coords

    else
      @busstops = BusstopDetail.all
    end
    respond_with @busstops
  end

  def show
    if params[:busline_id]
      @busstop = Busline.where(busnumber: params[:busline_id]).first.busstops.where(busstation_id: params[:id]).first.busstop_detail
    else
      @busstop = BusstopDetail.where(busstop_id: params[:id]).first
    end

    respond_with @busstop
  end
end
