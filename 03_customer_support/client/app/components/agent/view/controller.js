'use_strict';

angular.module('customerSupportApp')
  .controller('AgentViewtController', ['$scope', '$stateParams', '$state', 'Agent',
                                      function ($scope, $stateParams, $state, Agent){
  var urlParams = {id: $stateParams.id};

  Agent.remote.get(urlParams).$promise
  .then(function(agent){
    $scope.agents = agent;
  });

  $scope.viewSupportRequest = function(supportRequestId){
    $state.go('supportRequest-view', {id: supportRequestId});
  };

  $scope.removeAgent = function(){
    if(window.confirm("Are you sure?")){
      Agent.remote.remove({id: $scope.agent['id']}).$promise
      .then(function(){
        $state.go('agent-list');
      })
      .catch(function(error){
        window.alert('Cannot Delete Last Agent');
      });
    }
  };
}]);