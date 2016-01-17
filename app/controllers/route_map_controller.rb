require 'rest-client'
require 'json'
# require 'pry'

class RouteMapController < ApplicationController
  def show
    @features = []
    @lines_json = []

    if params.key?(:max)
      if params[:max].to_i <= 0
        lines = Busline.where(direction: 1).all.to_a
      elsif
        lines = Busline.limit(params[:max]).where(direction: 1).all.to_a
      end
    elsif
      lines = Busline.limit(10).where(direction: 1).all.to_a
    end
    generate_json_for(lines)
  end

  def night
    @features = []
    @lines_json = []
    lines = Busline.search_by_attribute('night').all.to_a
    generate_json_for(lines)
  end

  def add_features_for_stop(line, stop)
    desc = '<b>' + line.busnumber.to_s + '</b>: ' + stop.road + ', ' + stop.desc + ' (' + stop.busstop_id.to_s + ')'
    @features += [{ type: 'Feature', properties: { name: stop.road, popupContent: desc }, geometry: { type: 'Point', coordinates: [stop.long, stop.lat] } }]
  end

  def generate_json_for(buslines)
    buslines.each do |busline|
      add_features_for_stop(busline, busline.busstops.first.busstop_detail)
      add_features_for_stop(busline, busline.busstops.last.busstop_detail)

      line_coords = busline.coords
      color = format('#%06x', (rand * 0xffffff))
      @lines_json += [{ type: 'LineString', coordinates: line_coords, style: { color: color, opacity: 0.5, weight: 2 } }]

      # binding.pry
    end
  end
end
