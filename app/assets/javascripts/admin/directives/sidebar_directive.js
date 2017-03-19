app.directive('sidebar', [function(){
  // Runs during compile
  return {
    // name: '',
    // priority: 1,
    // terminal: true,
    // scope: {}, // {} = isolate, true = child, false/undefined = no change
    // controller: function($scope, $element, $attrs, $transclude) {},
    // require: 'ngModel', // Array = multiple requires, ? = optional, ^ = check parent elements
    restrict: 'C', // E = Element, A = Attribute, C = Class, M = Comment
    // template: '',
    // templateUrl: '',
    // replace: true,
    // transclude: true,
    // compile: function(tElement, tAttrs, function transclude(function(scope, cloneLinkingFn){ return function linking(scope, elm, attrs){}})),
    link: function($scope, iElm, iAttrs, controller) {
      var toggleSidebar;
      (toggleSidebar = function(){
        if (document.body.offsetWidth <= 1150) {
          $(iElm).addClass("collapse")
        } else {
          $(iElm).removeClass("collapse")
        }
      })();

      window.onresize = function() {
        toggleSidebar();
      }
      window.onresize();

      $('.page-bg').click(function () {
        toggleSidebar();
      })

      $('.toggle-sidebar').bind('click', function () {
        $('.sidebar').toggleClass('collapse')
      })
    }
  };
}]);