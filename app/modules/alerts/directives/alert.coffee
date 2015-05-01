angular.module 'alerts'
.directive 'alert', () ->
  restrict: 'EA'
  template:
    "<div class=\"alert alert-{{ type || 'warning' }} slide-up-animation \" role='alert'>\
      <button type='button' class='close' ng-click='close()'>\
        <span aria-hidden='true'>&times;</span>\
        <span class='sr-only'>Close</span>\
      </button>\
      <div ng-transclude></div>\
    </div>"
  transclude: true
  replace: true
  scope:
    type: '@'
    close: '&'
