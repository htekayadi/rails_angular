'use strict';

angular.module('customerSupport')
.factory('User', ['$resource', function($resource) {
  var remote = $resource('/api/users/:id/json', null, {
    'update': {method:'PUT'}
  });

  return {
    remote: remote
  };
}]);