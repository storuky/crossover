app.controller('AuthCtrl', ['action', '$http', function(action, $http){
  var ctrl = this;

  action("sign", function (params) {
    ctrl.submit = function () {
      $http.post(Routes['sign_'+params.type+'_path'](), {user: ctrl.user})
           .then(function (res) {
             gon.current_user = res.current_user;
           })
    }
  })
}])