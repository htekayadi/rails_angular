'use_strict';

angular.module('customerSupportApp')
  .controller('CustomerViewController', ['$scope', '$stateParams', '$state', 'Customer',
                                         function ($scope, $stateParams, $state, Customer) {

  var urlParams = {id: $stateParams.id};

  Customer.remote.get(urlParams).$promise
  .then(function(customer) {
    $scope.customers = customer;
  });

  $scope.viewSupportRequest = function(supportRequestId) {
    $state.go('supportRequest-view', {id: supportRequestId});
  };
}]);