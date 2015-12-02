class Api::BuslinesController < ApplicationController
  respond_to :json

  def index
    @buslines = Busline.all
    respond_with @buslines
  end

  def show
    # TODO well, busnumber should be unique, but each line has two directions
   @busline = Busline.where(busnumber: params[:id]).first 
   respond_with @busline
  end
end
