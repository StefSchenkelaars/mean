#!/usr/bin/env coffee

# Module dependencies
################################################################################
init = require('./config/init')()
config = require './config/config'
chalk = require 'chalk'
console.log chalk.grey('Starting ' + config.app.title)
mongoose = require 'mongoose'

# Database setup
################################################################################
db = mongoose.connect config.db.uri, config.db.options, (err) ->
  if err
    console.error chalk.red('Could not connect to MongoDB!')
    console.log chalk.red(err)

mongoose.connection.on 'error', (err) ->
  console.error chalk.red('MongoDB connection error: ' + err)
  process.exit -1

# Express setup
################################################################################
app = require('./config/express')(db)
app.listen config.port

# Logging init
################################################################################
console.log chalk.green('--------------------------------------------------------------------------------')
console.log chalk.green(config.app.title + ' application started')
console.log chalk.green('Environment:\t\t\t' + process.env.NODE_ENV)
console.log chalk.green('Port:\t\t\t\t' + config.port)
console.log chalk.green('Database:\t\t\t' + config.db.uri)
console.log chalk.green('--------------------------------------------------------------------------------')
