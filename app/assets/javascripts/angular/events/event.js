var app = angular.module('railsAngular');

app.factory('Event', ['$resource', function($resource) {
  return $resource('/api/events:id.json', { id: '@id' }, {
    search: {
      method: 'GET',
      isArray: true,
      url: '/api/events/search.json',
      params: {
        query: '@query'
      }
    }
  });
}]);