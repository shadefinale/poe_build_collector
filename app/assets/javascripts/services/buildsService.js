myApp.factory('Builds', ['Restangular', function(Restangular){
  var builds = []

  Restangular.all('builds').getList().then(function(buildList){
    builds.push.apply(builds, buildList);
  })

  return {
    builds: builds
  }

}])
