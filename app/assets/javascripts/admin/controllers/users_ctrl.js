app.controller('AdminUsersCtrl', ['action', 'AdminUser', '$scope', function (action, AdminUser, $scope) {
  var ctrl = this;

  action('index', function () {
    $scope.$watch('ctrl.filter', function (filter) {
      AdminUser.query(filter, function (res, h) {
        ctrl.users = res;
        ctrl.total_count = h().total_count;
      });
    }, true)
  })

  action('edit', function (params) {
    ctrl.user = AdminUser.get(params)
    ctrl.save = AdminUser.update;

    ctrl.block = function () {
      AdminUser.block(params, function () {
        ctrl.user.banned = true;
      })
    }

    ctrl.unblock = function () {
      AdminUser.unblock(params, function () {
        ctrl.user.banned = false;
      })
    }
  })
}])