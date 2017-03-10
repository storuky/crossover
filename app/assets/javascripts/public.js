//= require shared
//= require_self
//= require_tree ./public

var app = angular.module("app", ['oxymoron', 'ng-pagination', '720kb.tooltips', 'ngDialog', 'ngSanitize', 'textAngular', 'ngTouch', 'vcRecaptcha'])

app.run(['$rootScope', function($rootScope){
  $rootScope.gon = gon;
  
  $rootScope.$on('$stateChangeSuccess',function(){
    $("html, body").animate({ scrollTop: 0 });
  });
}])
