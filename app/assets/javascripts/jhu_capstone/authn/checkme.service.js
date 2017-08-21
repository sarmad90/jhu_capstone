(function() {
  "use strict";

  angular
    .module("jhu_capstone.authn")
    .factory("jhu_capstone.authn.checkMe", CheckMeFactory);

  CheckMeFactory.$inject = ["$resource", "jhu_capstone.config.APP_CONFIG"];
  function CheckMeFactory($resource, APP_CONFIG) {
    return $resource(APP_CONFIG.server_url + "/authn/checkme");
  }
})();
