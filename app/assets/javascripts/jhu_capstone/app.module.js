(function(){
  "use strict";

  angular
    .module("jhu_capstone", [
      "ui.router",
      "jhu_capstone.config",
      "jhu_capstone.authn",
      "jhu_capstone.layout",
      "jhu_capstone.foos",
      "jhu_capstone.cities",
      "jhu_capstone.subjects",
    ]);

})();
