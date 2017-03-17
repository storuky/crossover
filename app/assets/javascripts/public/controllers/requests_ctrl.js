app.controller('PublicRequestsCtrl', ['action', 'PublicRequest', 'PublicRequestMessage', '$scope', '$timeout', '$state', function (action, PublicRequest, PublicRequestMessage, $scope, $timeout, $state) {
  var ctrl = this;

  action('index', function (params) {
    ctrl.fetch = function (page) {
      params.page = page || 1;
      ctrl.requests = PublicRequest.query(params, function (res, h) {
        ctrl.total_count = h().total_count;
      });
    }

    $scope.$on('new_request_message', function (e, data) {
      _.each(ctrl.requests, function (request, index) {
        if (request && data.message[6] == request[0]) {
          ctrl.requests.splice(index, 1)
        }
      })

      ctrl.requests.unshift(data.request)
    })

    ctrl.fetch()
  })

  action('new', function () {
    ctrl.save = PublicRequest.create;
  })

  action('show', function (params) {
    ctrl.request = PublicRequest.get(params);
    PublicRequestMessage.query({request_id: params.id}, function (res) {
      ctrl.messages = res;
    });

    ctrl.send = function () {
      PublicRequestMessage.create({request_id: params.id, content: ctrl.content}, function () {
        ctrl.content = "";
      })
    }

    $scope.$on('new_request_message', function (e, data) {
      if (data.message[6] == params.id)
        ctrl.messages.push(data.message);
    })

    $scope.$watchCollection('ctrl.messages', function (messages, old) {
      $timeout(function () {
        var duration = old ? 200 : 0;
        $("html, body").animate({ scrollTop: $(document).height() }, duration);
      })
    })
  })
}])