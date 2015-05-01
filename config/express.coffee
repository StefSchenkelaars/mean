# Module dependencies
################################################################################
config = require './config'
express = require 'express'
bodyParser = require 'body-parser'
glob = require 'glob'
path = require 'path'
morgan = require 'morgan'

# Module init function
################################################################################
module.exports = (db) ->
  # Initialize express app
  app = express()

  # Logging
  app.use(morgan(config.log.format, config.log.options))

  # Load all models
  glob.sync('./server/models/**/*.coffee').forEach (modelPath) ->
    require(path.resolve(modelPath))

  # Request body parsing
  app.use bodyParser.urlencoded
    extended: true
  app.use bodyParser.json()

  # Load all routes
  glob.sync('./server/routes/**/*.coffee').forEach (routePath) ->
    require(path.resolve(routePath))(app)

  # Serve static files
  app.use(express.static(path.resolve('./public')))

  # Return the app
  app
