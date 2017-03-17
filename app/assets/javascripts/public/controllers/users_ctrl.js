app.controller('PublicUsersCtrl', ['action', 'PublicUser', function (action, PublicUser) {
  var ctrl = this;

  action('edit', function (params) {
    ctrl.user = PublicUser.get(params);
    ctrl.save = function (data) {
      PublicUser.update(data, function (res) {
        gon.current_user = res.current_user;
      })
    }
  })

  action('show', function (params) {
    ctrl.user = PublicUser.get(params);
  })
}])