app.service('SignService', ['$http', function($http){
  var SignService = this;

  SignService.in = function (user) {
    var promise = $http.post(Routes['login_path'](), {user: user})
    return promise;
  }

  SignService.up = function (user) {
    var promise = $http.post(Routes['register_path'](), {user: user})
    
    promise.then(function success (res) {}, function error (res) {
      grecaptcha.reset();
    })

    return promise;
  }

  SignService.out = function () {
    var promise = $http.delete(Routes['logout_path']())
    
    promise.then(function success (res) {
      gon.current_user = null;
    })

    return promise;
  }
}])