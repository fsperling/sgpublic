json.busstopdetails @busstops do |busstop|
  if busstop.instance_of? Busstop
    json.busnumber busstop.busnumber
    json.direction busstop.direction
    json.busstation_id busstop.busstation_id
  else
    json.busstation_id busstop.busstop_id
  end
end
