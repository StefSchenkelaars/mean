angular.module 'mean'
.controller 'MainController', ($log) ->
  scope = this
  $log.debug 'MainController: Initialized'
