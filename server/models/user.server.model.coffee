# Dependencies
################################################################################
mongoose = require 'mongoose'

# Validations
################################################################################
validatePresence = (property) ->
  property.length

# Schema
################################################################################
UserSchema = new mongoose.Schema
  name:
    type: String
    default: ''
    trim: true
    validate: [validatePresence, 'Please fill in your name']
  email:
    type: String
    unique: true
    trim: true
    validate: [validatePresence, 'Please fill in your email']
    match: [/.+\@.+\..+/, 'Please fill a valid email address']
    lowercase: true
  updated_at:
    type: Date
    default: Date.now

module.exports = mongoose.model 'User', UserSchema
