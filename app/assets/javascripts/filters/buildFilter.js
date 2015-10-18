// Accepts a collection of builds, and selects ones where the character class
// in question is still selected (true)
myApp.filter('selectedChars', function(){
  return function(collection, criteria){
    return collection.filter(function(el){
      return criteria[el.char-1];
    })
  }
})
