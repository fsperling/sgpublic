var onEachFeature, map, myLayer;

$(document).ready(function() {
  var features, lines;
  map = L.map('map').setView([1.355, 103.83], 12);
  L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18,
    id: 'fxsp.cigtcq7dl07dkthknvcsmpcqv',
    accessToken: 'pk.eyJ1IjoiZnhzcCIsImEiOiJjaWd0Y3E4c2gwN2RvdGhrbjhtbmx1c3p3In0.ztPbhslQyLXLWR3c32vpGw'
  }).addTo(map);

  myLayer = L.geoJson.css("", {
    onEachFeature: onEachFeature
  }).addTo(map);

  features = $('#features').data('features');
  myLayer.addData(features);

  lines = $('#lines').data('lines');
  return myLayer.addData(lines);
});


onEachFeature = function(feature, layer) {
  if (feature.properties && feature.properties.popupContent) {
    return layer.bindPopup(feature.properties.popupContent);
  }
};


