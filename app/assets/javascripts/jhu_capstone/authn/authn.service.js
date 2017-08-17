(function() {
  "use strict";

  angular
    .module("jhu_capstone.authn")
    .service("jhu_capstone.authn.Authn", Authn);

  Authn.$inject = ["$auth"];

  function Authn($auth) {
    var service = this;
    service.signup = signup;
    service.user = null;
    service.isAuthenticated = isAuthenticated;
    service.getCurrentUserName = getCurrentUserName;
    service.getCurrentUser = getCurrentUser;

    return;

    function signup(registration) {
      return $auth.submitRegistration(registration);
    }
    function isAuthenticated() {
      return service.user && service.user("uid");
    }
    function getCurrentUserName() {
      return service.user ? service.user.name : null;
    }
    function getCurrentUser() {
      return service.user;
    }
  };
})();
