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
        paths: {},
        geojson: {}
      });

    $scope.searchBuslines = function(query) {
      if (query.loc == true) {
        searchByLocation(query.dist);
      } else if (query.lat != null && query.lng != null) {
        getNearbyLinesFor('lat=' + query.lat + '&long=' + query.lng, query.dist);
        addHomeIcon(query.lat, query.lng);
        addCircleAroundHome(query.lat, query.lng, query.dist);
      } else if (query.zip != null) {
        getNearbyLinesFor('zipcode=' + query.zip, query.dist);
        loc = geocode('zipcode', query.zip)
      } else if (query.stopid != null) {
        //getNearbyLinesFor('busstation=' + query.stopid, query.dist);
        $scope.loc = [];
        geocode('busstation', query.stopid)
        console.log($scope.loc);
        addHomeIcon($scope.loc[0], $scope.loc[1]);
      }
    };

    function geocode(param, descriptor) {
      query = '?' + param + '=' + descriptor;
      $http.get('api/geocode' + query).success(function(data) {
        angular.extend($scope, { loc: data });
      });
    }

    $http.get('api/buslines').success(function(data) {
      $scope.lines = data.buslines;
    });

    var addHomeIcon = function(lat, lng) {
      console.log(lat + ' ' + lng);
      angular.extend($scope.markers["homeLocation"] = {
        lat: parseFloat(lat),
        lng: parseFloat(lng),
        icon: {
          type: 'awesomeMarker',
          icon: 'home',
          markerColor: 'red'
        }
      });
    };
  
    var addCircleAroundHome = function(lat, lng, r) {
        angular.extend($scope.paths["circle"] = {
              type: "circle",
              weight: 1,
              color: 'red',
              fillColor: 'red',
              opacity: 0.5,
              radius: r,
              latlngs: [ lat, lng ]
          });
    };

    $scope.resetForm = function(search) {
      search.loc = "";
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
            });
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
            });
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

    function searchByLocation(dist) {
        dist = dist || 300;
        var url = "http://freegeoip.net/json/";
        $http.get(url).success(function(res) {
            $scope.center = {
                lat: res.latitude,
                lng: res.longitude,
                zoom: 16
            };
            //$scope.center = { autoDiscover: true };
            $scope.ip = res.ip;
            console.log(res);
            addHomeIcon(res.latitude, res.longitude);
            addCircleAroundHome(res.latitude, res.longitude, dist); 
            getNearbyLinesFor('lat=' + res.latitude + '&long=' + res.longitude, dist);
            //getNearbyLinesFor('lat=' + $scope.center.lat + '&long=' + $scope.center.lng , 400);
        });
    };


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
