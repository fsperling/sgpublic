class Api::BuslinesController < ApplicationController
  respond_to :json

  def index
    respond_with Busline.all
  end

  def show
    # TODO well, busnumber should be unique, but each line has two directions
   respond_with Busline.where(busnumber: params[:id]).first 
  end
end
