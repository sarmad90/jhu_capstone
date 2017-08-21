(function() {
  "use strict";

  angular
    .module("jhu_capstone.authn")
    .factory("jhu_capstone.authn.whoAmI", WhoAmIFactory);

  WhoAmIFactory.$inject = ["$resource", "jhu_capstone.config.APP_CONFIG"];
  function WhoAmIFactory($resource, APP_CONFIG) {
    return $resource(APP_CONFIG.server_url + "/authn/whoami");
  }
})();
