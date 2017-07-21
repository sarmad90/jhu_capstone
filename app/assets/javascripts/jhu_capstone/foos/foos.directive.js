(function() {
  "use strict";

  angular
    .module("jhu_capstone.foos")
    .directive("sdFoos", FoosDirective);

  FoosDirective.$inject = ["jhu_capstone.APP_CONFIG"];

  function FoosDirective(APP_CONFIG) {
    var directive = {
      templateUrl: APP_CONFIG.foos_html,
      replace: true,
      bindToController: true,
      controller: "jhu_capstone.foos.FoosController",
      controllerAs: "foosVM",
      restrict: "E",
      scope: {},
      link: link
    };
    return directive;

    function link(scope, element, attrs) {
      console.log("FoosDirective", scope)
    };
  };
})();
