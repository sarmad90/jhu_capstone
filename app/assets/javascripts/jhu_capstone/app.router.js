(function() {
  "use strict";

  angular
    .module("jhu_capstone")
    .config(RouterFunction);

  RouterFunction.$inject = ["$stateProvider",
                            "$urlRouterProvider",
                            "jhu_capstone.config.APP_CONFIG"];

  function RouterFunction($stateProvider, $urlRouterProvider, APP_CONFIG) {
    $stateProvider
      .state("home", {
        url: "/",
        templateUrl: APP_CONFIG.main_page_html,
        // controller: ,
        // controllerAs: ,
      })

    $urlRouterProvider.otherwise("/");
  };
})();
