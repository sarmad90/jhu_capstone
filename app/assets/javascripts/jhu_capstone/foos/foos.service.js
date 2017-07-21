(function(){
  "use strict";

  angular
    .module("jhu_capstone.foos")
    .factory("jhu_capstone.foos.Foo", FooFactory);

    FooFactory.$inject = ["$resource", "jhu_capstone.APP_CONFIG"];

    function FooFactory($resource, APP_CONFIG) {
      return $resource(APP_CONFIG.server_url + "/api/foos/:id",
        { id: "@id" },
        { update: { method: "PUT" } }
      )
    }

})();
