require 'busstop_detail'

class Geocoder
  def location_by_zipcode(zip)
    loc = Geokit::Geocoders::GoogleGeocoder.geocode zip
    { lat: loc.lat, long: loc.lng }
  end

  def location_by_stopid(stopid)
    BusstopDetail.details_for(stopid)
  end
end
