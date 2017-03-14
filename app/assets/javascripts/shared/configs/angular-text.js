app.run(['$rootScope', function($rootScope) {
  $rootScope.taToolbar = [['bold','italics','underline'],['ol', 'ul'],['undo', 'redo', 'clear'], ['insertLink']];
}])