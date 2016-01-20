class Busline < ActiveRecord::Base
  has_many :busstops, foreign_key: 'busnumber', primary_key: 'busnumber'
  validates :busnumber, presence: true
  validates :start_code, presence: true
  validates :end_code, presence: true

  def coords
    line_coords = []
    busstops.map(&:busstop_detail).each do |stop|
      unless stop.nil?
        if stop.long.nil? || stop.lat.nil?
          Rails.logger.error "Busstop has no coords: #{stop}"
        else
          line_coords += [[stop.long, stop.lat]]
        end
      end
    end
    line_coords
  end

  def self.night_buslines
    Busline.where("freq_am_peak = '-' and freq_am_off = '-' and freq_pm_peak = '-' and freq_pm_off != '-'")
  end

  # bit useless
  # def self.search_by_busnumber(number)
  # Busline.where(busnumber: number).first
  # end

  def self.search_by_attribute(attribute)
    night_buslines if attribute.eql? 'night'
  end

  def self.find_nearby_to(params)
    dist = params[:dist] || 700
    dist_in_km = dist.to_f / 1000

    coord = coords_for(params)
    stops = BusstopDetail.stops_nearby_to(coord, dist_in_km)
    Busstop.buslines_frequenting(stops)
  end

  def self.location_by_zipcode(zip)
    Geokit::Geocoders::GoogleGeocoder.geocode zip
  end

  def self.coords_for(params)
    if params.key?('lat') && params.key?('long')
      [params[:lat], params[:long]]
    else
      retrieve_coords(params)
    end
  end

  def self.retrieve_coords(params)
    if params.key?('zipcode')
      loc = location_by_zipcode(params[:zipcode] + 'Singapore')
      [loc.lat, loc.lng]
    elsif params.key?('busstation')
      stop = BusstopDetail.details_for(params[:busstation])
      [stop[:lat], stop[:long]]
    end
  end
end
