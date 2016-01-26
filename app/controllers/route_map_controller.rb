require 'rest-client'
require 'json'
# require 'pry'

class RouteMapController < ApplicationController
  def show
    @features = []
    @lines_json = []

    number_of_lines = parse(params)
    if number_of_lines < 0
      lines = Busline.where(direction: 1).all.to_a
    else
      lines = Busline.limit(number_of_lines).where(direction: 1).all.to_a
    end
    generate_json_for(lines)
  end

  def test
  end

  def night
    @features = []
    @lines_json = []
    lines = Busline.search_by_attribute('night').all.to_a
    generate_json_for(lines)
  end

  def parse(params)
    number = 10
    if params.key?(:max)
      if params[:max].to_i <= 0
        number = -1
      else
        number = params[:max].to_i
      end
    end

    number
  end

  def add_features_for_stop(line, stop)
    desc = "<b>#{line.busnumber}</b>: #{stop.road}, #{stop.desc} (#{stop.busstop_id})"
    coord = [stop.long, stop.lat]
    @features += [{ type: 'Feature', properties: { name: stop.road, popupContent: desc }, geometry: { type: 'Point', coordinates: coord } }]
  end

  def generate_json_for(buslines)
    buslines.each do |busline|
      add_features_for_stop(busline, BusstopDetail.where(busstop_id: busline.start_code).first)
      add_features_for_stop(busline, BusstopDetail.where(busstop_id: busline.end_code).first)

      line_coords = busline.coords
      color = format('#%06x', (rand * 0xffffff))
      @lines_json += [{ type: 'LineString', coordinates: line_coords, style: { color: color, opacity: 0.5, weight: 2 } }]

      # binding.pry
    end
  end
end
