'use_strict';

angular.module('customerSupportApp')
  .controller('AdminCreateController', ['$scope', '$state', '$filter', 'Admin',
                                        function ($scope, $state, $filter, Admin) {
  $scope.submitAdminForm = function(form) {
    var postData = {
      'admin': form
    };

    Admin.remote.save({}, postData).$promise
    .then(function(createAdmin){
      $state.go('admin-view', {id: createdAdmin['id']});
    })
    .catch(function(error) {
      var errorData = error.data;
      var errorField = Object.keys(errorData)[0];
      var errorText = errorData[errorField][0];

      $scope.error = $filter('capitalize')(errorField) + " " + errorText;
    });
  };
}]);