$(document).ready ->
  map = L.map('map').setView([
    1.29777
    103.85325
  ], 13)
  
  L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}',
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>'
    maxZoom: 18
    id: 'fxsp.cigtcq7dl07dkthknvcsmpcqv'
    accessToken: 'pk.eyJ1IjoiZnhzcCIsImEiOiJjaWd0Y3E4c2gwN2RvdGhrbjhtbmx1c3p3In0.ztPbhslQyLXLWR3c32vpGw').addTo map
 
  features = $('#features').data('features')
  lines = $('#lines').data('lines')

  myLayer = L.geoJson.css().addTo map
  #myLayer.addData features
  myLayer.addData lines

 
  #for station in station_details
    #marker = L.marker([
      #station.lat
      #station.long
    #]).addTo map

    #marker.bindPopup(station.road + "<br>" + station.desc)

 
 
