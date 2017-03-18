app.controller('PublicSearchCtrl', ['$scope', 'action', 'SearchService', 'PublicRequest', function ($scope, action, SearchService, PublicRequest) {
  var ctrl = this;

  action('index', function (params) {
    SearchService.query = params.query;

    ctrl.fetch = function (page) {
      params.page = page;
      params.query = SearchService.query;
      
      ctrl.requests = []
      SearchService.find(params).then(function (res) {
        ctrl.requests = res.data;
        ctrl.total_count = res.headers().total_count;
      })
    }

    ctrl.fetch(1)

  })

  $scope.$on("$destroy", function () {
    SearchService.query = null;
  })
}])