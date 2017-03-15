app.controller('AdminRequestsCtrl', ['action', 'AdminRequest', '$scope', 'AdminUser', 'AdminRequestMessage', '$timeout', function (action, AdminRequest, $scope, AdminUser, AdminRequestMessage, $timeout) {
  var ctrl = this;

  action('index', function (params) {
    ctrl.resetFilter = function () {
      ctrl.filter = {
        status: "Opened",
        category_ids: _.pluck(gon.categories, 'id')
      }
      ctrl.userSearchStr = "";
    }

    ctrl.generatePDF = function () {
      ctrl.filter.format = "pdf";
      window.open(Routes.admin_requests_path(ctrl.filter));
    }

    ctrl.generateCSV = function () {
      ctrl.filter.format = "csv";
      window.open(Routes.admin_requests_path(ctrl.filter));
    }
    
    ctrl.fetch = function (page) {
      ctrl.filter.page = page || 1;
      ctrl.filter.user_id = ctrl.filter.user ? ctrl.filter.user.originalObject[0] : null;

      ctrl.requests = AdminRequest.query(ctrl.filter, function (res, h) {
        ctrl.total_count = h().total_count;
      });
    }

    $scope.$watch('ctrl.filter', function (filter) {
      if (filter)
        ctrl.fetch(1)
    }, true)

    ctrl.resetFilter()
  })

  action('show', function (params) {
    ctrl.request = AdminRequest.get(params, function (res) {
      ctrl.user = AdminUser.get({id: res.user_id})
    });

    AdminRequestMessage.query({request_id: params.id}, function (res) {
      ctrl.messages = res;
    });

    ctrl.close = function () {
      if (confirm("Are you sure?"))
        AdminRequest.close(params, function () {
          ctrl.request.status = "closed";
        })
    }

    ctrl.open = function () {
      if (confirm("Are you sure?"))
        AdminRequest.open(params, function () {
          ctrl.request.status = "opened";
        })
    }

    ctrl.send = function () {
      AdminRequestMessage.create({request_id: params.id, content: ctrl.content}, function () {
        ctrl.content = "";
      })
    }

    $scope.$watchCollection('ctrl.messages', function (messages, old) {
      if (messages) {
        $timeout(function () {
          var duration = old ? 200 : 0;
          $(".request-body").animate({ scrollTop: $(".request-body")[0].scrollHeight }, duration);
        })
      }
    })

    $scope.$on('new_request_message', function (e, data) {
      if (data[6] == params.id)
        ctrl.messages.push(data);
    })
  })
}])