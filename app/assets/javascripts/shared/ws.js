app.run(['$rootScope', function($rootScope){
  var Appcable = ActionCable.createConsumer();
  Appcable.subscriptions.create("RequestChannel", {
    received: function(data) {
      $rootScope.$broadcast("new_request_message", data);
      $rootScope.$apply();
    }
  })
}])