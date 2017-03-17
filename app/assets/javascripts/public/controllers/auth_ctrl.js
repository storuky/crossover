app.controller('AuthCtrl', ['action', '$http', function(action, $http){
  var ctrl = this;

  action("sign", function (params) {
    var methods = {
      in: "login",
      up: "register"
    }

    ctrl.user = {
      action: methods[params.type]
    }

    ctrl.submit = function ($event) {

      $http.post(Routes[methods[params.type]+'_path'](), {user: ctrl.user})
           .then(function (res) {
             if (!res.data.reload) gon.current_user = res.data.current_user;
           }, function () {
            grecaptcha.reset();
           })

      $event.preventDefault();
      $event.stopPropagation();
    }
  })
}])