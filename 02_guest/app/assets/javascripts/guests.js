var guestCenter = angular.module('GuestCenter', ['ngResource']);

guestCenter.factory("Guest", function($resource) {
  return $resource("guests/:id", { id: '@id' }, {
    index: { method: 'GET', isArray: true, responseType: 'json' },
    update: { method: 'PUT', responseType: 'json' }
  });
})

guestCenter.controller("guestsController", function($scope, Guest) {
  $scope.guests = Guest.index()

  $scope.addGuest = function() {
    guest = Guest.save($scope.newGuest)

    $scope.guests.push(guest)
    $scope.newGuest = {}
  }

  $scope.deleteGuest = function(index) {
    guest = $scope.guests[index]
    Guest.delete(guest)
    $scope.guests.splice(index, 1);
  }
})