angular.module 'mean.users'
.factory 'User', ($resource, AlertService) ->
  User = $resource 'users/:id', { id: '@id'}
  users = null

  UserFactory =
    all: (force_reload = false) ->
      if users == null || force_reload
        users = User.query()
      else
        users

    new: () ->
      new User()

    create: (attributes) ->
      new User(attributes).$save {}, (user) ->
        AlertService.add 'success', 'User saved'
        users.push(user)

    destroy: (user_id) ->
      User.delete({ id: user_id }, (success) ->
        # Remove user from list
        user = users.filter((user) -> user._id == user_id)[0]
        index = users.indexOf(user)
        users.splice(index, 1)
        AlertService.add 'success', 'User deleted'
      ).$promise
