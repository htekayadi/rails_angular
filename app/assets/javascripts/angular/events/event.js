var app = angular.module('railsAngular');

app.factory('Event', ['$resource', function($resource) {
  return $resource('/api/events:id.json', { id: '@id' });
}]);