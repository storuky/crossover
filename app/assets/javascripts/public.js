//= require shared
//= require_self
//= require_tree ./public
//= require_tree ./shared

var app = angular.module("app", ['oxymoron', 'bw.paging', 'ngDialog', 'ngSanitize', 'textAngular', 'ngTouch', 'vcRecaptcha'])

app.run(['$rootScope', 'SearchService', function($rootScope, SearchService){
  $rootScope.gon = gon;
  $rootScope.Routes = Routes;
  $rootScope.SearchService = SearchService;
  
  $rootScope.$on('$stateChangeSuccess',function(){
    $("html, body").animate({ scrollTop: 0 });
  });
}])
