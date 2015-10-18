myApp.controller('baseCtrl', ['$scope', 'Builds', 'Filter', function($scope, Builds, Filter){
  $scope.builds = Builds.builds;
  $scope.chars = Filter.chars;
  console.log($scope.builds);
}])
