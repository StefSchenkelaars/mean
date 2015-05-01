# Dependencies
################################################################################
mongoose = require 'mongoose'
respHandler = require './responses.server.controller'
User = mongoose.model 'User'

# Actions
################################################################################
exports.index = (req, res) ->
  User.find (err, users) ->
    res.json(users)

exports.create = (req, res) ->
  user = new User(req.body)

  user.save (err) ->
    if err
      res.status(422).send respHandler.getErrorMessage(err)
    else
      res.json user

exports.destroy = (req, res) ->
  User.findById(req.params.id).remove (err) ->
    if err
      res.status(500).send respHandler.getErrorMessage(err)
    else
      res.json respHandler.getSuccessMessgae('User destroyed')
