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

  AuthnSessionController.$inject = ["$scope", "jhu_capstone.authn.Authn"];
  function AuthnSessionController($scope, Authn) {
    var vm = this;
    vm.loginForm = {};
    vm.login = login;
    vm.logout = logout;
    vm.getCurrentUser = Authn.getCurrentUser;
    vm.getCurrentUserName = Authn.getCurrentUserName;

    vm.$onInit = function() {
      console.log("AuthnSessionController", $scope);
    }

    return;
    //////
    function login() {
      $scope.login_form.$setPristine();
      console.log("login");
      Authn.login(vm.loginForm).then(
        function(){
          $("#login-dropdown").removeClass("open");
        },
        function(response) {
          vm.loginForm["errors"] = response.errors;
        }
      )
    }
    function logout() {
      Authn.logout().then(function() {
        $("#login-dropdown").removeClass("open");
      });
    }
  };


})();
