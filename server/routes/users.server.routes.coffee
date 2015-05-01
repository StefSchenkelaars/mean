module.exports = (app) ->
  users = require '../../server/controllers/users.server.controller'
  app.route('/users').get(users.index)
  app.route('/users').post(users.create)
  app.route('/users/:id').delete(users.destroy)
