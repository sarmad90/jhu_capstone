(function() {
  "use strict";

  angular
    .module("jhu_capstone.cities")
    .controller("jhu_capstone.cities.CitiesController", CitiesController);

  CitiesController.$inject = ["jhu_capstone.cities.City"];

  function CitiesController(City) {
    var vm = this;
    vm.cities;
    vm.city;
    vm.edit = edit;
    vm.create = create;
    vm.update = update;
    vm.remove = remove;
    vm.clearSelection = clearSelection;

    activate();
    return;

    function activate() {
      newCity();
      vm.cities = City.query();
    };

    function newCity() {
      vm.city = new City();
    };

    function handleError(response) {
      console.log(response);
    };

    function edit(object) {
      console.log("Selected", object);
      vm.city = object;
    };

    function create() {
      //console.log("creating foo", vm.foo);
      vm.city.$save()
        .then(function(response){
          console.log(response);
          vm.cities.push(vm.city);
        })
        .catch(handleError);
    };

    function update() {
      vm.city.$update()
        .then(function(response){
          console.log(response);
        })
        .catch(handleError);
    };

    function remove() {
      vm.city.$delete()
        .then(function(response){
          console.log(response);
          vm.cities = City.query();
          // replace edit area with prototype instance
          newCity();
        })
        .catch(handleError);
    };

    function clearSelection(){
      vm.city = new City();
    };

  };
})();
