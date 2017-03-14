app.service('Search', ['$state', function($state){
  var Search = this;

  Search.do = function () {
    $state.go('public_search_path', {query: Search.query})
  }
}])