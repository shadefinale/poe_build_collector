myApp.controller('charsFilterCtrl', ['$scope', 'Chars', function($scope, Chars){
  $scope.chars = Chars.selected;
  $scope.toggleCharacterClass = function(char){
    $scope.chars[char] = !$scope.chars[char]
  }
}])
