(function() {
  "use strict";

  angular
    .module("jhu_capstone.layout")
    .component("sdNavbar", {
      templateUrl: templateUrl,
      controller: NavbarController,
      //bindings: {},
    });

    templateUrl.$inject = ["jhu_capstone.config.APP_CONFIG"];
    function templateUrl(APP_CONFIG) {
      return APP_CONFIG.navbar_html;
    }

    NavbarController.$inject = ["$scope", "jhu_capstone.authn.Authn"];
    function NavbarController($scope, Authn) {
      var vm = this;
      vm.getLoginLabel = getLoginLabel;

      vm.$onInit = function() {
        console.log("NavbarController", $scope);
      }
      return;
      ///////////
      function getLoginLabel() {
        return Authn.isAuthenticated() ? Authn.getCurrentUserName() : "Login";
      };
    };


})();
