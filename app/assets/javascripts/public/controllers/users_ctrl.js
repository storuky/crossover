app.controller('PublicUsersCtrl', ['action', 'PublicUser', function (action, PublicUser) {
  var ctrl = this;

  action('edit', function () {
    ctrl.user = PublicUser.edit();
    ctrl.save = function (data) {
      PublicUser.update(data, function (res) {
        gon.current_user = res.current_user;
      })
    }

    ctrl.cancel = function () {
      if (confirm("Not undoable action. Are you ready?")) {
        PublicUser.destroy();
      }
    }
  })

  action('show', function (params) {
    ctrl.user = PublicUser.get(params);
  })
}])