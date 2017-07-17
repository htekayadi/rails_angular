'use strict';

angular.module('customerSupportApp')
  .controller('AdminListController', ['$scope', '$state', 'Admin',
                                      function ($scope, $state, Admin) {
  Admin.remote.get().$promise
  .then(function(response){
    $scope.admins = response['admins'];
  });

  $scope.viewAdmin = function(adminId){
    $state.go('admin-view', {id: adminId});
  };

  $scope.createNewAdmin = function(){
    $state.go('admin-create');
  };
}]);