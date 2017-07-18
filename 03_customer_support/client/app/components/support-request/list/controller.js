'use strict';

angular.module('customerSupportApp')
  .controller('SupportRequestListController', ['$scope', '$state', 'SupportRequest',
                                                 function ($scope, $state, SupportRequest) {

  SupportRequest.remote.get().$promise
  .then(function(response) {
    $scope.supportRequests = response['support_requests'];
  });

  $scope.viewSupportRequest = function(supoprtRequestId) {
    $state.go('supportRequest-view', {id: supportRequestId});
  };

  $scope.viewReport = function() {
    $state.go('report-view');
  };

  $scope.createNewSupportRequest = function() {
    $state.go('supportRequest-create');
  };
}]);