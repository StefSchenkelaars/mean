# Module dependencies
################################################################################
glob = require 'glob'
chalk = require 'chalk'

# Module init function
################################################################################
module.exports = () ->
  # Set the NODE_ENV
  files = glob.sync './config/env/' + process.env.NODE_ENV + '.coffee'
  unless files.length
    if process.env.NODE_ENV
      console.error chalk.red('No config files found for' + process.env.NODE_ENV + 'environment, switching to development')
    else
      console.error chalk.red('NODE_ENV is not set! Using development environment as default')
    process.env.NODE_ENV = 'development'
