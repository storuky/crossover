app.service('SearchService', ['$state', '$http', function($state, $http){
  var SearchService = this;

  SearchService.go = function () {
    $state.go('public_search_path', {query: SearchService.query})
  }

  SearchService.find = function (params) {
    return $http.get(Routes.public_search_path({format: "json"}), {params: params})
  }
}])