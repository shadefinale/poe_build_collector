myApp.factory('Builds', ['Restangular', function(Restangular){
  var builds = []

  Restangular.all('builds').getList().then(function(buildList){
    console.log('list');
    console.log(buildList);
    builds.push.apply(builds, buildList);
    console.log(builds);
  })

  return {
    builds: builds
  }

}])
