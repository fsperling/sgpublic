class Api::BusstopdetailsController < ApplicationController
  respond_to :json

  def index
    if params[:busline_id]
      respond_with Busline.where(busnumber: params[:busline_id]).first.busstops
    else
      respond_with BusstopDetail.all
    end
  end

  def show
    if params[:busline_id]
      respond_with Busline.where(busnumber: params[:busline_id]).first.busstops.where(busstation_id: params[:id]).first.busstop_detail
    else
      respond_with BusstopDetail.where(busstop_id: params[:id])
    end
  end
end
