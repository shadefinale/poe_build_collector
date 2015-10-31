describe('Filter: characterClass', function(){
  beforeEach(module('myApp'));

  it('has a characterClass filter', inject(function($filter){
    expect($filter('characterClass')).not.toBeNull();
  }))

  it('should properly return correct character name', inject(function(characterClassFilter){
    expect(characterClassFilter(1)).toEqual("Duelist");
    expect(characterClassFilter(2)).toEqual("Marauder");
    expect(characterClassFilter(3)).toEqual("Ranger");
    expect(characterClassFilter(4)).toEqual("Scion");
    expect(characterClassFilter(5)).toEqual("Shadow");
    expect(characterClassFilter(6)).toEqual("Templar");
    expect(characterClassFilter(7)).toEqual("Withch");
  }))

})
