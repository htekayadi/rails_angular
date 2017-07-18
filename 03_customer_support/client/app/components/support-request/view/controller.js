'use strict';

angular.module('customerSupportApp')
  .controller('SupportRequestViewController', ['$scope', '$stateParams', '$state', 'SupportRequest',
                                                 function ($scope, $stateParams, $state, SupportRequest) {

  var urlParams = {id: $stateParams.id};

  SupportRequest.remote.get(urlParams).$promise
  .then(function(supportRequest) {
    $scope.supportRequest = supportRequest;
  });

  $scope.closeSupportRequest = function() {
    var urlParams = {
      id: $scope.supportRequest['id']
    };

    var postParams = {
      'support_request': {
        status: 'closed'
      }
    };

    SupportRequest.remote.update(urlParams, postParams).$promise
    .then(function(updatedSupportRequest){
      $scope.supportRequest = updatedSupportRequest;
    })
    .catch(function(error) {
      window.alert('Error ' + error);
    });
  };

  $scope.reopenSupportRequest = function() {
    var urlParams = {
      id: $scope.supportRequest['id']
    };

    var postParams = {
      'support_request': {
        status: 'open'
      }
    };

    SupportRequest.remote.update(urlParams, postParams).$promise
    .then(function(updatedSupportRequest) {
      $scope.supportRequest = updatedSupportRequest;
    })
    .catch(function(error) {
      window.alert('Error ' + error);
    });
  };
}]);