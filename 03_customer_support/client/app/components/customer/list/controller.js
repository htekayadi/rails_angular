'use_strict';

angular.module('customerSupportApp')
  .controller('CustomerListController', ['$scope', '$state', 'Customer',
                                         function ($scope, $state, Customer) {
  Customer.remote.get().$promise
  .then(function(response) {
    $scope.customers = response['cutomers'];
  });

  $scope.viewCustomer = function(customerId) {
    $state.go('customer-view', {id: customerId});
  };
}]);