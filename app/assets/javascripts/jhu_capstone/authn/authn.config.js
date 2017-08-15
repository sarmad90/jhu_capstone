(function() {
  "use strict";

  angular
    .module("jhu_capstone.authn")
    .config(AuthnConfig);

  AuthnConfig.$inject = ["$authProvider", "jhu_capstone.config.APP_CONFIG"];

  function AuthnConfig($authProvider, APP_CONFIG) {
    $authProvider.configure({
      apiUrl: APP_CONFIG.server_url
    });
  }
})();
