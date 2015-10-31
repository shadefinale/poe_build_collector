myApp.controller('baseCtrl', ['$scope', 'Builds', 'Chars', function($scope, Builds, Chars){
  $scope.builds = Builds.builds;
  $scope.chars = Chars.selected;
}])
