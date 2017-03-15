app.directive('switcher', [function(){
  // Runs during compile
  return {
    // name: '',
    // priority: 1,
    // terminal: true,
    scope: {
      items: "=",
      selectedItem: "="
    }, // {} = isolate, true = child, false/undefined = no change
    // controller: function($scope, $element, $attrs, $transclude) {},
    // require: 'ngModel', // Array = multiple requires, ? = optional, ^ = check parent elements
    // restrict: 'A', // E = Element, A = Attribute, C = Class, M = Comment
    // template: '',
    templateUrl: 'admin/components/switcher.html',
    // replace: true,
    // transclude: true,
    // compile: function(tElement, tAttrs, function transclude(function(scope, cloneLinkingFn){ return function linking(scope, elm, attrs){}})),
    link: function($scope, iElm, iAttrs, controller) {
      $scope.setActive = function (item) {
        $scope.selectedItem = item;
      }
      $scope.isActive = function (item) {
        return JSON.stringify($scope.selectedItem) == JSON.stringify(item);
      }
    }
  };
}]);