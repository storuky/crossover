app.service('SignService', ['$http', function($http){
  var SignService = this;

  SignService.in = function (user) {
    return $http.post(Routes['login_path'](), {user: user})
  }

  SignService.up = function (user) {
    return $http.post(Routes['register_path'](), {user: user})
                .then(function success (res) {}, function error (res) {
                  grecaptcha.reset();
                })
  }

  SignService.out = function () {
    return $http.delete(Routes['logout_path']())
         .then(function success (res) {
           gon.current_user = null;
         })
  }
}])