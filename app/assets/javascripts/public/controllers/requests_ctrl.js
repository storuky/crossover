app.controller('PublicRequestsCtrl', ['action', 'PublicRequest', 'PublicRequestMessage', '$scope', '$timeout', '$state', function (action, PublicRequest, PublicRequestMessage, $scope, $timeout, $state) {
  var ctrl = this;

  action('index', function (params) {
    $scope.page = params.page;

    ctrl.pagingAction = function (page) {
      params.page = page;
      ctrl.requests = PublicRequest.query(params, function (res, h) {
        ctrl.total_count = h().total_count;
      });
    }

    ctrl.pagingAction(params.page || 1)
  })

  action('new', function () {
    ctrl.save = PublicRequest.create;
  })

  action('show', function (params) {
    ctrl.request = PublicRequest.get(params);
    ctrl.messages = PublicRequestMessage.query({request_id: params.id});

    ctrl.send = function () {
      PublicRequestMessage.create({request_id: params.id, content: ctrl.content}, function () {
        ctrl.content = "";
      })
    }

    $scope.$on('new_request_message', function (e, data) {
      ctrl.messages.push(data);
    })

    $scope.$watchCollection('ctrl.messages', function (messages) {
      $timeout(function () {
        $("html, body").animate({ scrollTop: $(document).height() }, 300);
      })
    })
  })
}])