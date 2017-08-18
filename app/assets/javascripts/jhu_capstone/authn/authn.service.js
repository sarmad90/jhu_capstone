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
    service.login = login;
    service.logout = logout;

    activate();
    return;

    function activate() {
      $auth.validateUser().then(function(user) {
        service.user = user;
      });
    };
    function signup(registration) {
      return $auth.submitRegistration(registration);
    }
    function isAuthenticated() {
      return service.user && service.user.uid;
    }
    function getCurrentUserName() {
      return service.user ? service.user.name : null;
    }
    function getCurrentUser() {
      return service.user;
    }
    function logout() {
      console.log("logout");
      var result = $auth.signOut();
      result.then(function(response) {
        service.user = null;
        console.log("Logout complete", response);
      },
      function(response) {
        service.user = null;
        console.log("Logout failure", response);
        alert(response.status + ":" + response.statusText);
      });
      return result;
    }
    function login(credentials) {
      console.log("login", credentials.email);
      var result = $auth.submitLogin({
        email: credentials["email"],
        password: credentials["password"]
      });

      result.then(function(response){
        console.log('login complete', response);
        service.user = response;
      });

      return result;
    }
  };
})();
