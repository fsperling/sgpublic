class Busline < ActiveRecord::Base
  has_many :busstops, foreign_key: 'busnumber', primary_key: 'busnumber'

  validates :busnumber, presence: true
  validates :start_code, presence: true
  validates :end_code, presence: true

  def get_coords
    line_coords = []
    self.busstops.map(&:busstop_detail).each do |stop|

      unless stop == nil
        if stop.long == nil || stop.lat == nil
          #log error: no coords
        else
          line_coords += [[stop.long, stop.lat]]
        end
      end
    end
    line_coords
  end

  def self.search_by_busnumber(number)
    Busline.where(busnumber: number).first
  end

  def self.search_by_attribute(attribute)
    if attribute.eql? "night"
      Busline.where("freq_am_peak == '-' and freq_am_off == '-' and freq_pm_peak == '-' and freq_pm_off != '-'")
    end
  end
  
  def self.search_by_area(params)
    dist = params[:dist] ||= 100
    if params.has_key?("lat") && params.has_key?("long")
      lat = params[:lat]
      long = params[:long]
    elsif params.has_key?("zipcode")
      loc = Geokit::Geocoders::GoogleGeocoder.geocode params[:zipcode] + "Singapore"
      lat = loc.lat
      long = loc.lng
    elsif params.has_key?("busstation")
      stop = BusstopDetail.where(busstop_id: params[:busstation]).first
      lat = stop[:lat]
      long = stop[:long]
    end

    stops = BusstopDetail.within(dist.to_f/1000, origin: [lat, long]).map(&:busstop_id)
    lines = Busstop.where(busstation_id: stops).map(&:busnumber).uniq
  end

end


#@features += [{type: 'Feature', properties: {name: stop.road}, geometry: {type: 'Point', coordinates: [stop.long, stop.lat]} }]
