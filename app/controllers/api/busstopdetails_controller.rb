class Api::BusstopdetailsController < ApplicationController
  respond_to :json, :geojson

  def index
    if params[:busline_id]
      @busstops = Busline.where(busnumber: params[:busline_id]).first.busstops
      @coordinates = Busline.where(busnumber: params[:busline_id]).first.coords

    else
      @busstops = BusstopDetail.all
    end
    respond_with @busstops
  end

  def show
    if params[:busline_id]
      busstops = Busline.where(busnumber: params[:busline_id]).first.busstops
      @busstop = busstops.where(busstop_id: params[:id]).first.busstop_detail
    else
      @busstop = BusstopDetail.where(busstop_id: params[:id]).first
    end

    respond_with @busstop
  end
end
