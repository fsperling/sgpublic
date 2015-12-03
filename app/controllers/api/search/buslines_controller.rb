class Api::Search::BuslinesController < ApplicationController
  respond_to :json

  def index
    if params.has_key?(:number)
      @response = Busline.search_by_busnumber(params[:number])
    elsif params.has_key?(:attribute)
      @response = Busline.search_by_attribute(params[:attribute])
    elsif params.has_key?(:lat) || params.has_key?(:zipcode) || params.has_key?(:busstation)
      @response = Busline.search_by_area(params)
    end

    respond_with @response
  end

end
