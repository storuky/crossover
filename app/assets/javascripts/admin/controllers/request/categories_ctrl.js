app.controller('AdminRequestCategoriesCtrl', ['action', 'AdminRequestCategory', function(action, AdminRequestCategory){
  var ctrl = this;

  action('index', function () {
    ctrl.categories = AdminRequestCategory.query();
  })

  action('edit', function (params) {
    ctrl.request_category =  AdminRequestCategory.get(params)
    ctrl.save = AdminRequestCategory.update;
    ctrl.destroy = function () {
      AdminRequestCategory.destroy(params)
    }
  })

  action('new', function () {
    ctrl.save = AdminRequestCategory.create;
  })
}])