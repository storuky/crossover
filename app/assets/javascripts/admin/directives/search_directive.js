app.directive('search', [function(){
  // Runs during compile
  return {
    // name: '',
    // priority: 1,
    // terminal: true,
    scope: {
      query: "="
    }, // {} = isolate, true = child, false/undefined = no change
    // controller: function($scope, $element, $attrs, $transclude) {},
    // require: 'ngModel', // Array = multiple requires, ? = optional, ^ = check parent elements
    // restrict: 'A', // E = Element, A = Attribute, C = Class, M = Comment
    // template: '',
    templateUrl: 'admin/components/search.html',
    replace: true,
    // transclude: true,
    // compile: function(tElement, tAttrs, function transclude(function(scope, cloneLinkingFn){ return function linking(scope, elm, attrs){}})),
    link: function($scope, iElm, iAttrs, controller) {
      $scope.reset = function () {
        $scope.query = null;
      }
    }
  };
}]);