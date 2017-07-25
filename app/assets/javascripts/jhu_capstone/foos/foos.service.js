(function(){
  "use strict";

  angular
    .module("jhu_capstone.foos")
    .factory("jhu_capstone.foos.Foo", FooFactory);

    FooFactory.$inject = ["$resource", "jhu_capstone.APP_CONFIG"];

    function FooFactory($resource, APP_CONFIG) {
      return $resource(APP_CONFIG.server_url + "/api/foos/:id",
        { id: "@id" },
        {
          update: { method: "PUT",
                    transformRequest: buildNestedBody,
                  },
          save: { method: "POST",
                  transformRequest: buildNestedBody,
                },
        }
      )
    }

    //nests the default payload below a "foo" element as required by RAILS
    function buildNestedBody(data) {
      return angular.toJson({foo: data})
    }

})();
