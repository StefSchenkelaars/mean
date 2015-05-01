angular.module 'alerts'
.config ($httpProvider) ->
  $httpProvider.interceptors.push ($q, $rootScope, AlertService) ->
    'responseError': (response) ->
      switch response.status
        when 0 # No response at all
          AlertService.add 'danger', 'Could not connect to data server'
        when 401 # Not logged in
          AlertService.add 'danger', response.data.message
        when 422 # Errors in form
          if response.data.errors.length > 0
            for er in response.data.errors
              AlertService.add 'warning', er.message
          else
            AlertService.add 'warning', response.data.message
        else
          if typeof response.data.message != 'undefined'
            AlertService.add 'danger', response.data.message
          else
            AlertService.add 'danger', 'Error in the connection with the data server'
      return $q.reject response
