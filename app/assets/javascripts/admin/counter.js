app.run(['$rootScope', 'AdminRequest', function($rootScope, AdminRequest){
  $rootScope.$on('update_unreaded_count', function () {
    AdminRequest.unreaded_count(function (res) {
      gon.unreaded_count = res.unreaded_count
    });
    
  })
}])