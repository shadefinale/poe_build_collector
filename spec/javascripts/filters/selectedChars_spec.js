describe('Filter: selectedChars', function(){
  beforeEach(module('myApp'));

  it('has a selectedChars filter', inject(function($filter){
    expect($filter('selectedChars')).not.toBeNull();
  }))

  var buildsList;

  beforeEach(inject(function(){
    buildsList = [
      {
        char: 1
      },
      {
        char: 3
      },
      {
        char: 3
      },
      {
        char: 4
      },
      {
        char: 5
      },
      {
        char: 5
      },
      {
        char: 6
      },
    ]
  }))

  it('should properly filter a collection for single selection', inject(function(selectedCharsFilter){
    var selected = [true, false, false, false, false, false, false];
    expect(selectedCharsFilter(buildsList, selected).length).toEqual(1);
  }))

  it('should properly filter a collection for single selection and return multiple results',
    inject(function(selectedCharsFilter){
      var selected = [false, false, true, false, false, false, false];
      expect(selectedCharsFilter(buildsList, selected).length).toEqual(2);
    })
  )

  it('should properly filter a collection for multiple selections and return multiple results',
    inject(function(selectedCharsFilter){
      var selected = [false, false, true, true, false, false, false];
      expect(selectedCharsFilter(buildsList, selected).length).toEqual(3);
    })
  )
})
