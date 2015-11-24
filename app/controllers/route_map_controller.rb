require 'rest-client'
require 'json'
require 'pry'

class RouteMapController < ApplicationController
  def show
    @features = []
    @lines_json = []


    #lines = Busline.limit(50).where("direction == '1'").all.to_a
    lines = Busline.limit(50).all.to_a

    lines.each do |line| 
      line_coords = []
      line.busstops.map(&:busstop_detail).each do |stop|

        unless stop == nil
        if stop.long == nil || stop.lat == nil
          #log error: no coords
        else
          @features += [{type: 'Feature', properties: {name: stop.road}, geometry: {type: 'Point', coordinates: [stop.long, stop.lat]} }]
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
      firstStop = line.busstops.first.busstop_detail
      lastStop = line.busstops.last.busstop_detail
      descF = "<b>" + line.busnumber.to_s + "</b>: " + firstStop.road + ", " + firstStop.desc + " (" + firstStop.busstop_id.to_s + ")"
      descL = "<b>" + line.busnumber.to_s + "</b>: " + lastStop.road + ", " + lastStop.desc + " (" + lastStop.busstop_id.to_s + ")"
      @features += [{type: 'Feature', properties: {name: firstStop.road, popupContent: descF}, geometry: {type: 'Point', coordinates: [firstStop.long, firstStop.lat]} }]
      @features += [{type: 'Feature', properties: {name: lastStop.road, popupContent: descL}, geometry: {type: 'Point', coordinates: [lastStop.long, lastStop.lat]} }]

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

#  def generate
#    baseurl = "http://www.onemap.sg"
#    service = "/API/services.svc/getToken"
#    access_key = ENV['ONEMAP_ACCESS_KEY']
#
#    response = RestClient.get baseurl + service, {:params => {'accessKEY' => access_key}, :accept => :json}
#    if response.code != 200
#      #log error
#    end
#
#    tokenResp = JSON.parse response
#    accessToken = tokenResp["GetToken"][0]["NewToken"]
#
#  end

end
