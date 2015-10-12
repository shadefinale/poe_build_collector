myApp.controller('baseCtrl', ['$scope', 'Builds', function($scope, Builds){
  $scope.builds = Builds.builds;
  console.log($scope.builds);
}])
