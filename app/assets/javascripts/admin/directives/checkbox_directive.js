app.directive('checkbox', ['$compile', function($compile){
  // Runs during compile
  return {
    // name: '',
    // priority: 1,
    // terminal: true,
    scope: {
      ngModel: "=",
      list: "=",
      listValue: "=",
      label: "="
    }, // {} = isolate, true = child, false/undefined = no change
    // controller: function($scope, $element, $attrs, $transclude) {},
    // require: 'ngModel', // Array = multiple requires, ? = optional, ^ = check parent elements
    // restrict: 'A', // E = Element, A = Attribute, C = Class, M = Comment
    // template: '',
    templateUrl: 'admin/components/checkbox.html',
    replace: true,
    transclude: true,
    // compile: function(tElement, tAttrs, function transclude(function(scope, cloneLinkingFn){ return function linking(scope, elm, attrs){}})),
    link: function($scope, iElm, iAttrs, controller) {
      var template = $scope.list ?  '<input type="checkbox" checklist-model="ngModel" checklist-value="listValue">' : '<input type="checkbox" ng-model="ngModel">';
      $(iElm).prepend($compile(template)($scope))
    }
  };
}]);