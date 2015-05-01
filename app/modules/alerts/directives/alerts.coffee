angular.module 'alerts'
.directive 'alerts', () ->
  restrict: 'EA'
  template:
    "<div id='alerts' class='col-xs-12 col-sm-offset-6 col-sm-6  col-md-offset-8 col-md-4 col-lg-offset-9 col-lg-3'>\
      <alert ng-repeat='alert in alerts' type='{{alert.type}}' close='alert.close()'>\
        <span ng-bind='alert.msg'></span>\
      </alert>\
    </div>"
