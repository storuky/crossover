app.controller('PublicSearchCtrl', ['$scope', 'action', 'Search', 'PublicRequest', '$http', '$state', function ($scope, action, Search, PublicRequest, $http, $state) {
  var ctrl = this;

  action('index', function (params) {
    Search.query = params.query;

    ctrl.fetch = function (page) {
      params.page = page || 1;
      params.query = Search.query;
      
      ctrl.requests = []
      $http.get(Routes.public_search_path({format: "json"}), {params: params}).then(function (res) {
        ctrl.requests = res.data;
        ctrl.total_count = res.headers().total_count;
      })
    }

    ctrl.fetch(1)

  })

  $scope.$on("$destroy", function () {
    Search.query = null;
  })
}])