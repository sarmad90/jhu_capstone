(function() {
  "use strict";

  angular
    .module("jhu_capstone")
    .component("sdImageSelector", {
      templateUrl: imageSelectorTemplateUrl,
      controller: ImageSelectorController,
      bindings: {
        authz: "<"
      },
    })
    .component("sdImageEditor", {
      templateUrl: imageEditorTemplateUrl,
      controller: ImageEditorController,
      bindings: {
        authz: "<"
      },
    });

  imageSelectorTemplateUrl.$inject = ["jhu_capstone.config.APP_CONFIG"];
  function imageSelectorTemplateUrl(APP_CONFIG) {
    return APP_CONFIG.image_selector_html;
  }

  imageEditorTemplateUrl.$inject = ["jhu_capstone.config.APP_CONFIG"];
  function imageEditorTemplateUrl(APP_CONFIG) {
    return APP_CONFIG.image_editor_html;
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

  ImageEditorController.$inject = ["$scope", "$stateParams", "jhu_capstone.subjects.Image"];
  function ImageEditorController($scope, $stateParams, Image) {
    var vm = this;
    vm.$onInit = function() {
      console.log("ImageEditorController", $scope);
      if ($stateParams.id) {
        vm.item = Image.get({id: $stateParams.id});
      } else {
        newResource();
      }

    }
    return;
    /////
    function newResource() {
      vm.item = new Image();
      return vm.item;
    }
  }
})();
