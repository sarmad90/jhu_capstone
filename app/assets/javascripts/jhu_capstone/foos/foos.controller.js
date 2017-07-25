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

    function edit(object, index) {

    };

    function create() {

    };

    function update() {

    };

    function remove() {

    };

    function removeElement(elements, element) {

    };

  };
})();
