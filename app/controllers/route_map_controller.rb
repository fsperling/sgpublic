require 'rest-client'
require 'json'
require 'pry'

class RouteMapController < ApplicationController
  def show
    @features = []
    @lines_json = []


    lines = Busline.limit(10).where("direction == '1'").all.to_a

    lines.each do |line| 
      route_info = Busroute.where(:busnumber => line[:busnumber]).where(:direction => '1').select("stop_number", "busstation_id")
      stations = Busroute.where(:busnumber => line[:busnumber]).where(:direction => '1').map(&:busstation_id)
      station_details = Busstop.where(code: stations)

      #binding.pry
      line_coords = []
      route_info.each do |stop|
        stop_details = station_details.find {|e| e[:code] == stop["busstation_id"] }
        unless stop_details == nil
        if stop_details["long"] == nil || stop_details["lat"] == nil
          #log error: no coords
          
        else
          @features += [{type: 'Feature', properties: {name: stop_details["road"]}, geometry: {type: 'Point', coordinates: [stop_details["long"], stop_details["lat"]]} }]
          line_coords += [[stop_details["long"], stop_details["lat"]]]
        end
        end
      end
      color = "#" +  "%06x" % (rand * 0xffffff)
      @lines_json += [{type: 'LineString', coordinates: line_coords, style: { color: color, opacity: 0.5, weight: 2, lineCap: "butt", lineJoin: "round"} }] 

      #binding.pry
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
