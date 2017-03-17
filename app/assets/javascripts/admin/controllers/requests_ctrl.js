app.controller('AdminRequestsCtrl', ['action', 'AdminRequest', '$scope', 'AdminUser', 'AdminRequestMessage', '$timeout', '$localStorage', '$httpParamSerializer', '$rootScope', function (action, AdminRequest, $scope, AdminUser, AdminRequestMessage, $timeout, $localStorage, $httpParamSerializer, $rootScope) {
  var ctrl = this;

  action('index', function (params) {
    ctrl.resetFilter = function () {
      ctrl.filter = {
        status: "Opened",
        category_ids: _.pluck(gon.categories, 'id'),
        page: 1,
        user: null,
        user_id: null,
        sort: ctrl.filter && ctrl.filter.sort ? ctrl.filter.sort : gon.requests_order_by[0]
      }
      ctrl.userSearchStr = "";

      $localStorage.filter = ctrl.filter;
      $localStorage.userSearchStr = ctrl.userSearchStr;
    }

    ctrl.generateReport = function (format) {
      ctrl.filter.format = format;
      window.open(Routes.admin_requests_path(ctrl.filter));
    }
    
    ctrl.fetch = function () {
      ctrl.filter.user_id = ctrl.filter.user ? ctrl.filter.user.originalObject[0] : null;

      ctrl.requests = AdminRequest.query(ctrl.filter, function (res, h) {
        ctrl.total_count = h().total_count;
      });
    }

    $scope.$watch('ctrl.filter', function (filter) {
      if (filter) ctrl.fetch()
    }, true)

    $scope.$on('new_request_message', function (e, data) {
      _.each(ctrl.requests, function (request, index) {
        if (request && data.message[6] == request[0]) {
          ctrl.requests.splice(index, 1)
        }
      })

      ctrl.requests.unshift(data.request)
    })

    if ($localStorage.filter) {
      ctrl.filter = $localStorage.filter;
      ctrl.userSearchStr = $localStorage.userSearchStr;
    } else {
      ctrl.resetFilter()
    }

  })

  action('show', function (params) {
    ctrl.request = AdminRequest.get(params, function (res) {
      ctrl.user = AdminUser.get({id: res.user_id});
      $rootScope.$broadcast("update_unreaded_count");
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
      if (data.message[6] == params.id) {
        ctrl.messages.push(data.message);
        read();
      }
    })
    read();

    function read() {
      AdminRequest.read(params, function () {
        $rootScope.$broadcast("update_unreaded_count");
      });
    }
  })
}])