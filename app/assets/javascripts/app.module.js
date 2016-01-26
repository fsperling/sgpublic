var app = angular.module('app', ['ui-leaflet'] );

app.controller('BusCtrl', 
  ['$scope', '$http', 'leafletMapEvents', function($scope, $http, leafletMapEvents) {
  //['$scope', function($scope) {

        angular.extend($scope, {
                center: {
                    lat: 51.505,
                    lng: -0.09,
                    zoom: 12
                },
                defaults: {
                    tileLayer: "http://{s}.tile.opencyclemap.org/cycle/{z}/{x}/{y}.png",
                    zoomControlPosition: 'topright',
                    tileLayerOptions: {
                        opacity: 0.9,
                        detectRetina: true,
                        reuseTiles: true,
                    },
                    scrollWheelZoom: false
                }
            });

/*

    var onEachFeature, map, myLayer, features, lines;

    $http.get('api/buslines').success(function(data) {
      $scope.lines = data.buslines;
    });

    $scope.displayBusline = function(number) {
       getAndDrawBusline(number);
     };


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
      myLayer.addData(lines);

*/


            $scope.eventDetected = "No events yet...";
            var mapEvents = leafletMapEvents.getAvailableMapEvents();
            for (var k in mapEvents){
                var eventName = 'leafletDirectiveMap.' + mapEvents[k];
                $scope.$on(eventName, function(event){
                    $scope.eventDetected = event.name;
                });
            }

map.on('locationfound', function (locationEvent) {
  var lat = locationEvent.latitude;
  var lng = locationEvent.longitude;
  getNearbyLinesFor('lat=' + lat + '&long=' + lng, 500);

/*
    onEachFeature = function(feature, layer) {
      if (feature.properties && feature.properties.popupContent) {
        return layer.bindPopup(feature.properties.popupContent);
      }
    };

    var getAndDrawBusline = function(number) {
      $http.get('api/buslines/' + number + '/busstopdetails.geojson').success(function(lines) {
         myLayer.addData(lines);
       });
       $http.get('api/buslines/' + number + '.geojson').success(function(features) {
         myLayer.addData(features) 
       });  
    };


    $scope.clearMap = function() {
      map.removeLayer(myLayer);
      myLayer = L.geoJson.css("", {
        onEachFeature: onEachFeature
      }).addTo(map);
    };

    $scope.searchBuslines = function(query) {
      if (query.lat !== null && query.lng !== null) {
        getNearbyLinesFor('lat=' + query.lat + '&long=' + query.lng, query.dist);
      } else if (query.zip !== null) {
        getNearbyLinesFor('zipcode=' + query.zip, query.dist);
      } else if (query.stopid !== null) {
        getNearbyLinesFor('busstation=' + query.stopid, query.dist);
      }
    };

    $scope.location = function() {
      map.locate({setView: true, maxZoom: 14});
    };

    $scope.resetForm = function(search) {
      search.lat = "";
      search.lng = "";
      search.zip = "";
      search.stopid = "";
      search.dist = "";
      $scope.searchForm.$setPristine(true);
    };


    var getNearbyLinesFor = function(param, dist) {
        if (dist !== null) {
          param = param + '&dist=' + dist
        }
        $http.get('api/search/buslines?' + param).success(function(lines) {
        angular.forEach(lines, function(line) {
          getAndDrawBusline(line);
        });  
      });
    };

})
*/

}]);
