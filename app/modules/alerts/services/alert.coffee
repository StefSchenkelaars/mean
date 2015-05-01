angular.module 'alerts'
.factory 'AlertService', ($rootScope, $timeout) ->
  # create an array of alerts available globally
  $rootScope.alerts = []

  AlertService =
    add: (type, msg) ->
      $rootScope.alerts.push { type: type, msg: msg, close: ->
        AlertService.closeAlert(this)
        }
      alert = $rootScope.alerts[$rootScope.alerts.length - 1]
      $timeout () ->
        index = $rootScope.alerts.indexOf(alert)
        $rootScope.alerts.splice index, 1
      ,4000

    closeAlert: (alert) ->
      @closeAlertIdx $rootScope.alerts.indexOf(alert)
    closeAlertIdx: (index) ->
      $rootScope.alerts.splice index, 1
