json.busstopdetails @busstops do |busstop|
  if busstop.instance_of? Busstop
    json.busnumber busstop.busnumber
    json.direction busstop.direction
  end
  json.busstop_id busstop.busstop_id
end
