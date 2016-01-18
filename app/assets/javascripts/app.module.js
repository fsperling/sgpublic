app = angular.module('app', []);

app.controller('BusCtrl', 
  ['$scope', '$http', function($scope, $http) {
    $http.get('api/buslines').success(function(data) {
      $scope.lines = data.buslines;
    });

    $scope.displayBusline = function(number) {
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
      if(query.lat != null && query.long != null) {
        $http.get('api/search/buslines?' + 'lat=' + query.lat + '&long=' + query.long).success(function(lines) {
          
      });
      }
    };

}]);
