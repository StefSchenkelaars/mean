# Module dependencies
################################################################################
_ = require 'lodash'
glob = require 'glob'

# Module init function
################################################################################
module.exports = _.extend(
    require('./env/application'),
    require('./env/' + process.env.NODE_ENV)
  )
