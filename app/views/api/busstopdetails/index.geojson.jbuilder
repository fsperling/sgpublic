json.type "LineString"
json.coordinates @coordinates
json.style do 
  json.color format('#%06x', (rand * 0xffaaff))
  json.opacity 0.5
  json.weight 2
end
