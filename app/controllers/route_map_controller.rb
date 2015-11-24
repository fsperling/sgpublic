require 'rest-client'
require 'json'
require 'pry'

class RouteMapController < ApplicationController
  def show
    @features = []
    @lines_json = []
    lines = Busline.limit(50).where("direction == '1'").all.to_a

    lines.each do |line| 
      line_coords = []
      add_features_for_stop(line, line.busstops.first.busstop_detail)
      add_features_for_stop(line, line.busstops.last.busstop_detail)
      line.busstops.map(&:busstop_detail).each do |stop|

        unless stop == nil
        if stop.long == nil || stop.lat == nil
          #log error: no coords
        else
          #@features += [{type: 'Feature', properties: {name: stop.road}, geometry: {type: 'Point', coordinates: [stop.long, stop.lat]} }]
          line_coords += [[stop.long, stop.lat]]
        end
        end
      end
      color = "#" +  "%06x" % (rand * 0xffffff)
      @lines_json += [{type: 'LineString', coordinates: line_coords, style: { color: color, opacity: 0.5, weight: 2 }}] 

      #binding.pry
    end
  end

  def night
    @features = []
    @lines_json = []
    lines = Busline.where("freq_am_peak == '-' and freq_am_off == '-' and freq_pm_peak == '-' and freq_pm_off != '-'").all.to_a

    lines.each do |line| 
      line_coords = []
      add_features_for_stop(line, line.busstops.first.busstop_detail)
      add_features_for_stop(line, line.busstops.last.busstop_detail)

      line.busstops.map(&:busstop_detail).each do |stop|
        unless stop == nil
          if stop.long == nil || stop.lat == nil
            #log error: no coords
          else
            #@features += [{type: 'Feature', properties: {name: stop.road}, geometry: {type: 'Point', coordinates: [stop.long, stop.lat]} }]
            line_coords += [[stop.long, stop.lat]]
          end
        end
      end
      color = "#" +  "%06x" % (rand * 0xffffff)
      @lines_json += [{type: 'LineString', coordinates: line_coords, style: { color: color, opacity: 0.5, weight: 2 }}] 

    end
  end

  def add_features_for_stop(line, stop)
      desc = "<b>" + line.busnumber.to_s + "</b>: " + stop.road + ", " + stop.desc + " (" + stop.busstop_id.to_s + ")"
      @features += [{type: 'Feature', properties: {name: stop.road, popupContent: desc}, geometry: {type: 'Point', coordinates: [stop.long, stop.lat]} }]

  end
end
