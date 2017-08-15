(function(){
  "use strict";

  angular
    .module("jhu_capstone.cities")
    .factory("jhu_capstone.cities.City", CityFactory);

    CityFactory.$inject = ["$resource", "jhu_capstone.config.APP_CONFIG"];

    function CityFactory($resource, APP_CONFIG) {
      return $resource(APP_CONFIG.server_url + "/api/cities/:id",
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

    //nests the default payload below a "city" element as required by RAILS
    function buildNestedBody(data) {
      return angular.toJson({city: data})
    }

})();
