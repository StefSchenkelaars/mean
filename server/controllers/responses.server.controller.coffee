getUniqueErrorMessage = (err) ->
  try
    fieldName = err.errmsg.substring(err.errmsg.lastIndexOf('.$') + 2, err.errmsg.lastIndexOf('_1'))
    output = fieldName.charAt(0).toUpperCase() + fieldName.slice(1) + ' already exists'
  catch ex
    output = 'Unique field already exists';
  output

exports.getErrorMessage = (err) ->
  messgage = 'Error when saving'
  errors = []

  if err.code
    switch err.code
      when 11000, 11001
        message = getUniqueErrorMessage(err)
        break;
      else
        message = 'Something went wrong'
  else
    message = err.message
    if err.errors
      for field, error of err.errors
        errors.push
          message: error.message
          value: error.value

  { message: message, errors: errors }

exports.getSuccessMessgae = (message) ->
  { message: message }
