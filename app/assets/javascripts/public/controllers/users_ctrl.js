app.controller('PublicUsersCtrl', ['action', 'PublicUser', function (action, PublicUser) {
  var ctrl = this;

  action('edit', function (params) {
    ctrl.user = PublicUser.get(params);
    ctrl.save = PublicUser.update;
  })

  action('show', function (params) {
    ctrl.user = PublicUser.get(params);
  })
}])