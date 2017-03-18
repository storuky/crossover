app.controller('AuthCtrl', ['action', 'SignService', function(action, SignService){
  var ctrl = this;

  action("sign", function (params) {
    ctrl.submit = function ($event) {
      SignService[params.type](ctrl.user).then(function (res) {
        if (!res.data.reload)
          gon.current_user = res.data.current_user;
      })

      $event.preventDefault();
      $event.stopPropagation();
    }
  })
}])