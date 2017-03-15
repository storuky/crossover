app.controller('AdminUsersCtrl', ['action', 'AdminUser', '$scope', function (action, AdminUser, $scope) {
  var ctrl = this;

  action('index', function () {
    $scope.$watch('ctrl.filter', function (filter) {
      ctrl.users = AdminUser.query(filter);
    }, true)
  })

  action('edit', function (params) {
    ctrl.user = AdminUser.get(params)
    ctrl.save = AdminUser.update;

  })
}])