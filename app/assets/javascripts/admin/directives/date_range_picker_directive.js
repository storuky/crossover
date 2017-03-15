app.directive('dateRangePicker', [function(){
  // Runs during compile
  return {
    // name: '',
    // priority: 1,
    // terminal: true,
    scope: {
      dateFrom: "=",
      dateTo: "="
    }, // {} = isolate, true = child, false/undefined = no change
    // controller: function($scope, $element, $attrs, $transclude) {},
    // require: 'ngModel', // Array = multiple requires, ? = optional, ^ = check parent elements
    // restrict: 'A', // E = Element, A = Attribute, C = Class, M = Comment
    // template: '',
    // templateUrl: '',
    // replace: true,
    // transclude: true,
    // compile: function(tElement, tAttrs, function transclude(function(scope, cloneLinkingFn){ return function linking(scope, elm, attrs){}})),
    link: function($scope, iElm, iAttrs, controller) {
      var changedFromCallback = false;
      $(iElm).dateRangePicker()
             .bind('datepicker-change',function(event,obj) {
                $scope.dateFrom = obj.date1;
                $scope.dateTo = obj.date2;
                changedFromCallback = true;
                $scope.$apply();
              })

      $scope.$watchGroup(['dateFrom', 'dateTo'], function (dates) {
        if (dates[0] && dates[1] && !changedFromCallback)
          $(iElm).data('dateRangePicker').setDateRange(dates[0], dates[1]);
        
        if (!dates[0] && !dates[1])
          $(iElm).data('dateRangePicker').clear()

        changedFromCallback = false;
      })
    }
  };
}]);