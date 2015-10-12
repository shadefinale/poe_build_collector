var myApp = angular.module('myApp', ["mobile-angular-ui", "ui.router", "restangular", 'angular.filter']);

myApp.config(['RestangularProvider', function(RestangularProvider){
  RestangularProvider.setRequestSuffix(".json")
}])

.config(['$stateProvider', '$urlRouterProvider',
  function($stateProvider, $urlRouterProvider){
    $urlRouterProvider.otherwise('/');

    $stateProvider
      .state('/', {
        url: '/',
        templateUrl: 'templates/base.html',
        controller: 'baseCtrl'
      })
      // .state('/filter', {
      //   url: '/filter',
      //   templateUrl: 'templates/filter.html',
      //   controller: 'filterCtrl'
      // })
      // .state('/authors', {
      //   url: '/authors',
      //   templateUrl: 'templates/authors.html',
      //   controller: 'authorsCtrl'
      // })
      // .state('/author', {
      //   url: '/author/:id'
      //   templateUrl: 'templates/author.html',
      //   controller: 'authorCtrl',
      // })
  }
])
