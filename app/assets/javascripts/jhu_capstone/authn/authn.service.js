(function() {
  "use strict";

  angular
    .module("jhu_capstone.authn")
    .service("jhu_capstone.authn.Authn", Authn);

  Authn.$inject = ["$auth"];

  function Authn($auth) {
    var service = this;
    service.signup = signup;

    return;

    function signup(registration) {
      return $auth.submitRegistration(registration);
    }
  };
})();
