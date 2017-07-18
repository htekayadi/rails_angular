'use strict';

angular.module('customerSupportApp')
  .controller('ReportViewController', ['$scope', '$state', '$q', 'Report', 'SupportRequest',
                                       function ($scope, $state, $q, Report, SupportRequest) {
  SupportRequest.remote.get({report: 'true'}).$promise
  .then(function(response) {
    $scope.supportRequests = response['support_requests'];
  });

  $scope.downloadReport = function() {
    var fileName = "Report.pdf";

    /**
     * Creating a hidden link element to enable triggering the download of the file by the browser
     */
    var hiddenFileLink = document.createElement("a");
    document.body.appendChild(hiddenFileLink);
    hiddenFileLink.style = "display: none";

    Report.get()
    .then(function(result) {
      try{
        var file = new Blob([result.data], {type: 'application/pdf'});
        var fileURL = window.URL.createObjectURL(file);
        hiddenFileLink.href = fileURL;
        hiddenFileLink.download = fileName;
        hiddenFileLink.click();
      }
      catch(error) {
        return $q.reject(error);
      }
    })
    .catch(function(error) {
      window.alert('Error ' + error);
    });
  };

  $scope.viewSupportRequest = function(supportRequestId) {
    $state.go('supportRequest-view', {id: supportRequestId});
  };
}]);