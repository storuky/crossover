app.controller('AuthCtrl', ['action', 'SignService', function(action, SignService){
  var ctrl = this;
  ctrl.user = {};

  action("sign", function (params) {
    ctrl.submit = function ($event) {
      ctrl.user.action = params.type;
      SignService[params.type](ctrl.user).then(function (res) {
        if (!res.data.reload)
          gon.current_user = res.data.current_user;
      })

      $event.preventDefault();
      $event.stopPropagation();
    }
  })
}])