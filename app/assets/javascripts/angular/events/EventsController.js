var app = angular.module('railsAngular');

app.controller('EventsController', ['$scope', function($scope, Event) {
  $scope.events = Event.query();

  $scope.addEvent = function() {
    if (!valid()) {
      return false;
    }

    Event.save($scope.event,
      function(response, _headers) {
        $scope.events.push(response);
      },
      function(response) {
        alert('Errors: ' + response.date.errors.join(. ));
      }
    );

    $scope.event = {};
  };

  valid = function() {
    return !!$scope.event &&
      !!$scope.event.name && !!$scope.event.event_date &&
      !!$scope.event.description && !!$scope.event.place;
  }
}]);