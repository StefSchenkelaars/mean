angular.module 'mean.users'
.controller 'main.users.UserListController', ($log, User) ->
  scope = this
  $log.debug 'main.users.UserListController: Initialized'

  scope.users = User.all()
  scope.destroy = (user_id) ->
    User.destroy user_id
