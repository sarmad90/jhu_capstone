(function() {
  "use strict";

  angular
    .module("jhu_capstone")
    .component("sdImageSelector", {
      templateUrl: imageSelectorTemplateUrl,
      controller: ImageSelectorController,
      //bindings: {},
    });

  imageSelectorTemplateUrl.$inject = ["jhu_capstone.config.APP_CONFIG"];
  function imageSelectorTemplateUrl(APP_CONFIG) {
    return APP_CONFIG.image_selector_html;
  }

  ImageSelectorController.$inject = ["$scope", "$stateParams", "jhu_capstone.subjects.Image"];
  function ImageSelectorController($scope, $stateParams, Image) {
    var vm = this;
    vm.$onInit = function() {
      console.log("ImageSelectorController", $scope);
      if (!$stateParams.id) {
        vm.items = Image.query();
      }

    }
    return;
    /////
  }
})();
