{primary,secondary} = require '../language'
module.exports = class T
  constructor: (primaryValue,secondaryValue) ->
    @[primary.code] = primaryValue
    @[secondary.code] = if typeof secondaryValue == 'undefined' then primaryValue else secondaryValue
