'use_strict';

angular.module('customerSupportApp')
  .controller('AgentCreateController', ['$scope', '$state', '$filter', 'Agent',
                                        function ($scope, $state, $filter, Agent){
  $scope.submitAgentFrom = function(form){
    var postData = {
      'agent': form
    };

    Agent.remote.save({}, postData).$promise
    .then(function(createdAgent){
      $state.go('agent-view', {id: createdAgent['id']});
    })
    .catch(function(error){
      var errorData = error.data;
      var errorField = Object.keys(errorData)[0];
      var errorText = errorData[errorField][0];

      $scope.error = $filter('capitalize')(errorField) + " " + errorText;
    });
  };
}]);