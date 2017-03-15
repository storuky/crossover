app.controller('AuthCtrl', ['action', '$http', function(action, $http){
  var ctrl = this;

  action("sign", function (params) {
    ctrl.submit = function () {
      var methods = {
        in: "login",
        up: "register"
      }

      $http.post(Routes[methods[params.type]+'_path'](), {user: ctrl.user})
           .then(function (res) {
             gon.current_user = res.data.current_user;
           })
    }
  })
}])