require 'rest-client'
require 'json'
require 'pry'

class RouteMapController < ApplicationController

  def show
    @features = []
    @lines_json = []
    lines = Busline.limit(50).where("direction == '1'").all.to_a
    generate_json_for(lines)
  end

  def night
    @features = []
    @lines_json = []
    lines = Busline.where("freq_am_peak == '-' and freq_am_off == '-' and freq_pm_peak == '-' and freq_pm_off != '-'").all.to_a
    generate_json_for(lines)
  end

  def add_features_for_stop(line, stop)
      desc = "<b>" + line.busnumber.to_s + "</b>: " + stop.road + ", " + stop.desc + " (" + stop.busstop_id.to_s + ")"
      @features += [{type: 'Feature', properties: {name: stop.road, popupContent: desc}, geometry: {type: 'Point', coordinates: [stop.long, stop.lat]} }]

  end

  def generate_json_for(lines)
    lines.each do |line| 
      add_features_for_stop(line, line.busstops.first.busstop_detail)
      add_features_for_stop(line, line.busstops.last.busstop_detail)

      line_coords = line.get_coords
      color = "#" +  "%06x" % (rand * 0xffffff)
      @lines_json += [{type: 'LineString', coordinates: line_coords, style: { color: color, opacity: 0.5, weight: 2 }}] 

      #binding.pry
    end
  end
end
