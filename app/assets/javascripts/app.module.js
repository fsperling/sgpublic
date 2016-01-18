app = angular.module('app', []);

app.controller('BusCtrl', 
  ['$scope', '$http', function($scope, $http) {
    $http.get('api/buslines').success(function(data) {
      $scope.lines = data.buslines;
    });

    $scope.displayBusline = function(number) {
       getAndDrawBusline(number);
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
      if (query.lat != null && query.long != null) {
        getNearbyLinesFor('lat=' + query.lat + '&long=' + query.long);
      } else if (query.zip != null) {
        getNearbyLinesFor('zipcode=' + query.zip);
      } else if (query.stopid != null) {
        getNearbyLinesFor('busstation=' + query.stopid);
      }
    };

    $scope.resetForm = function(search) {
      search.lat = "";
      search.long = "";
      search.zip = "";
      search.stopid = "";
      $scope.searchForm.$setPristine(true);
    };

    var getNearbyLinesFor = function(param) {
        $http.get('api/search/buslines?' + param).success(function(lines) {
        angular.forEach(lines, function(line) {
          getAndDrawBusline(line);
        });  
      });
    };

}]);
