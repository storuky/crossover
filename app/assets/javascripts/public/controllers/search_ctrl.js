app.controller('PublicSearchCtrl', ['$scope', 'action', 'Search', 'PublicRequest', '$http', '$state', function ($scope, action, Search, PublicRequest, $http, $state) {
  var ctrl = this;

  action('index', function (params) {
    $scope.page = params.page;

    ctrl.pagingAction = function (page) {
      params.page = page;
      
      $http.get(Routes.public_search_path({format: "json"}), {params: params}).then(function (res) {
        ctrl.requests = res.data;
        ctrl.total_count = res.headers().total_count;
      })
    }

    ctrl.pagingAction(params.page || 1)

  })

  $scope.$on("$destroy", function () {
    Search.query = null;
  })
}])