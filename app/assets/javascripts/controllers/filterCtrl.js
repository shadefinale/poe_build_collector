myApp.controller('filterCtrl', ['$scope', 'Filter', function($scope, Filter){
  $scope.chars = Filter.chars;
  $scope.toggleCharacterClass = function(char){
    $scope.chars[char] = !$scope.chars[char]
  }
}])
