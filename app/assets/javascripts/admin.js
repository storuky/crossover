//= require shared
//= require moment.min
//= require jquery.daterangepicker.min
//= require angucomplete
//= require checklist-model
//= require_self
//= require_tree ./admin
//= require_tree ./shared

var app = angular.module("app", ['oxymoron', 'angucomplete', 'checklist-model', 'bw.paging', 'ngDialog', 'textAngular', 'ngTouch'])

app.run(['$rootScope', function($rootScope){
  $rootScope.gon = gon;
  $rootScope.Routes = Routes;
}])
