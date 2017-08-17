(function() {
  "use strict";

  angular
    .module("jhu_capstone.authn")
    .component("sdAuthnSession", {
      templateUrl: templateUrl,
      controller: AuthnSessionController,
      //bindings: {},
    });

  templateUrl.$inject = ["jhu_capstone.config.APP_CONFIG"];
  function templateUrl(APP_CONFIG) {
    return APP_CONFIG.authn_session_html;
  }

  AuthnSessionController.$inject = ["$scope"];
  function AuthnSessionController($scope) {
    var vm = this;

    vm.$onInit = function() {
      console.log("AuthnSessionController", $scope);
    }

    return;
    //////
  };


})();
