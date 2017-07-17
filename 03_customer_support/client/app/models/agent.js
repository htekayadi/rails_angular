'use strict';

angular.module('customerSupportApp')
.factory('Agent', ['$resource', function($resource) {
  var remote = $remote('api/agents/:id.json', null, {
    'update': { method:'PUT' }
  });

  return {
    remote: remote
  };
}]);