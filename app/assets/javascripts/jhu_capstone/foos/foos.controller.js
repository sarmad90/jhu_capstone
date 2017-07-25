(function() {
  "use strict";

  angular
    .module("jhu_capstone.foos")
    .controller("jhu_capstone.foos.FoosController", FoosController);

  FoosController.$inject = ["jhu_capstone.foos.Foo"];

  function FoosController(Foo) {
    var vm = this;
    vm.foos;
    vm.foo;
    vm.edit = edit;
    vm.create = create;
    vm.update = update;
    vm.remove = remove;

    activate();
    return;

    function activate() {
      newFoo();
      vm.foos = Foo.query();
    };

    function newFoo() {
      vm.foo = new Foo();
    };

    function handleError(response) {
      console.log(response);
    };

    function edit(object) {
      console.log("Selected", object);
      vm.foo = object;
    };

    function create() {
      //console.log("creating foo", vm.foo);
      vm.foo.$save()
        .then(function(response){
          console.log(response);
          vm.foos.push(vm.foo);
        })
        .catch(handleError);
    };

    function update() {
      vm.foo.$update()
        .then(function(response){
          console.log(response);
        })
        .catch(handleError);
    };

    function remove() {
      vm.foo.$delete()
        .then(function(response){
          console.log(response);
          // remove the element from the JS array
          // removeElement(vm.foos, vm.foo);
          vm.foos = Foo.query();
          // replace edit area with prototype instance
          newFoo();
        })
        .catch(handleError);
    };

    function removeElement(elements, element) {
      for(var i=0; i<elements.length, i++) {
        if (elements[i].id == element.id) {
          elements.splice(i, 1);
          break;
        }
      }
    };

  };
})();
