'use strict';

angular.module('customerSupportApp')
  .controller('UserLoginController', ['$scope', function ($scope) {
    /**
     * Sets $scope.error on receiving login error broadcast
     */
    $scope.$on('auth:login-error', function(event, reason) {
      if(reason){
        $scope.error = reason.errors[0];
      }
    });
}]);
