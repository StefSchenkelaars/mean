angular.module 'mean.users'
.controller 'main.users.UserFormController', ($log, User) ->
  scope = this
  $log.debug 'main.users.UserFormController: Initialized'

  scope.users = User.all()
  scope.newUser = User.new()
  scope.saveUser = () ->
    User.create(scope.newUser).then () ->
      scope.newUser = User.new()
