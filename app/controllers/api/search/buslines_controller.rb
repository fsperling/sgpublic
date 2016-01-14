class Api::Search::BuslinesController < ApplicationController
  respond_to :json

  def index
    # bit useless
    #if params.key?(:number)
    #  @response = Busline.search_by_busnumber(params[:number])
    if params.key?(:attribute)
      @response = Busline.search_by_attribute(params[:attribute])
    elsif params.key?(:lat) || params.key?(:zipcode) || params.key?(:busstation)
      @response = Busline.search_by_area(params)
    end

    respond_with @response
  end
end
