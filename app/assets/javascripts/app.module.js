var app = angular.module("sgapp", ["ui-leaflet"] );

app.controller("BusCtrl", 
  ["$scope", "$http", function($scope, $http) {
      angular.extend($scope, {
        center: {
          lat: 1.36,
          lng: 103.83,
          zoom: 12
        },
        defaults: {},
        markers: {},
        geojson:{}
      });

    $scope.searchBuslines = function(query) {
      if (query.lat != null && query.lng != null) {
        getNearbyLinesFor('lat=' + query.lat + '&long=' + query.lng, query.dist);
      } else if (query.zip != null) {
        getNearbyLinesFor('zipcode=' + query.zip, query.dist);
      } else if (query.stopid != null) {
        getNearbyLinesFor('busstation=' + query.stopid, query.dist);
      }
    };


    $http.get('api/buslines').success(function(data) {
      $scope.lines = data.buslines;
    });

    $scope.resetForm = function(search) {
      search.lat = "";
      search.lng = "";
      search.zip = "";
      search.stopid = "";
      search.dist = "";
      $scope.searchForm.$setPristine(true);
    };

    var getAndDrawBusline = function(number) {
    //id = (Math.random() + 1).toString(36).substring(7) + number.toString();
    $http.get('api/buslines/' + number  + '/busstopdetails.geojson').success(function(data, status) {
        angular.extend($scope.geojson[number] = {
                data: data,
                style: {
                    weight: 2,
                    opacity: 1,
                    color: get_random_color(),
                }
            }
        );
    });
    };

    var getAndDrawMarkerForBusline = function(number) {
        $http.get('api/buslines/' + number  + '.geojson').success(function(data, status) {
            data.forEach(addMarker);
        });
    };

    function addMarker(element, index, array) {
        id = (Math.random() + 1).toString(36).substring(7);
        angular.extend($scope.markers[id] = {
                lat: element['geometry']['coordinates'][1],
                lng: element['geometry']['coordinates'][0]
            }
        );
    }

    $scope.displayBusline = function(number) {
       getAndDrawBusline(number);
       getAndDrawMarkerForBusline(number);
     };

    $scope.clearMap = function() {
      $scope.geojson = {};
      $scope.markers = {};
    };

    var getNearbyLinesFor = function(param, dist) {
        if (dist != null) {
          param = param + '&dist=' + dist
        }
        $http.get('api/search/buslines?' + param).success(function(lines) {
        angular.forEach(lines, function(line) {
          getAndDrawBusline(line);
          getAndDrawMarkerForBusline(line);
        });  
      });
    };

    $scope.location = function(ip) {
        var url = "http://freegeoip.net/json/" + ip;
        $http.get(url).success(function(res) {
            $scope.center = {
                lat: res.latitude,
                lng: res.longitude,
                zoom: 12
            };
            //$scope.center = { autoDiscover: true };
            $scope.ip = res.ip;
            console.log(res);
            getNearbyLinesFor('lat=' + res.latitude + '&long=' + res.longitude, 400);
            //getNearbyLinesFor('lat=' + $scope.center.lat + '&long=' + $scope.center.lng , 400);
        });
    };

    $scope.location("");

    getAndDrawBusline("12");
    getAndDrawMarkerForBusline("12");

  function get_random_color() {
    function c() {
      return Math.floor(Math.random()*256).toString(16)
    }
    return "#"+c()+c()+c();
  }

/*
      map = L.map('map').setView([1.355, 103.83], 12);
        L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
        maxZoom: 18,
        id: 'fxsp.cigtcq7dl07dkthknvcsmpcqv',
        accessToken: 'pk.eyJ1IjoiZnhzcCIsImEiOiJjaWd0Y3E4c2gwN2RvdGhrbjhtbmx1c3p3In0.ztPbhslQyLXLWR3c32vpGw'
      }).addTo(map);

*/

/*
    onEachFeature = function(feature, layer) {
      if (feature.properties && feature.properties.popupContent) {
        return layer.bindPopup(feature.properties.popupContent);
      }
    };
})
*/

}]);
