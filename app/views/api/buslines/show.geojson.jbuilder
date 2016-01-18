json.array! @stops do |stop|
  json.type "Feature"
  json.properties do
    json.name stop.road
    json.popupContent @busline.busnumber + ": " + stop.road + ", " + stop.desc + " (" + stop.busstop_id.to_s + ")"
  end
  json.geometry do 
    json.type "Point"
    json.coordinates [stop.lat, stop.long]
  end
end
