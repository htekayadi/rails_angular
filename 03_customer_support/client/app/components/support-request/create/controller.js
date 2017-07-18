'use strict';

angular.module('customerSupportApp')
  .controller('SupportRequestCreateController', ['$scope', '$state', '$filter', 'SupportRequest',
                                                 function ($scope, $state, $filter, SupportRequest) {
  $scope.submitSupportRequest = function(form) {
    var postData = {
      'support_request': form
    };

    SupportRequest.remote.save({}, postData).$promise
    .then(function(createdSupportRequest) {
      $state.go('supportRequest-view', {id: createdSupportRequest['id']});
    })
    .catch(function(error) {
      var errorData = error.data;
      var errorField = Object.keys(errorData)[0];
      var errorText = errorData[errorField][0];

      $scope.error = $filter('capitalize')(errorField) + " " + errorText;
    });
  };
}]);