// Simple filter for taking integer and returning string
myApp.filter('characterClass', function(){
  return function(idx){
    var result = ['None', 'Duelist', 'Marauder', 'Ranger', 'Scion', 'Shadow', 'Templar', 'Witch'][idx.toString()];
    return result || 'None';
  }
})
