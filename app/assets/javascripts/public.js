//= require shared
//= require_self
//= require_tree ./public
//= require_tree ./shared

var app = angular.module("app", ['oxymoron', 'bw.paging', 'ngDialog', 'ngSanitize', 'textAngular', 'ngTouch', 'vcRecaptcha'])

app.run(['$rootScope', 'Search', function($rootScope, Search){
  $rootScope.gon = gon;
  $rootScope.Search = Search;
  $rootScope.Routes = Routes;
  
  $rootScope.$on('$stateChangeSuccess',function(){
    $("html, body").animate({ scrollTop: 0 });
  });
}])
