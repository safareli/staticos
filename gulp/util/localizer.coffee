vsprintf = require('sprintf').vsprintf || []
gutil = require("gulp-util")
R = require 'ramda'
T = require '../../src/data/constructors/t'
Path = require '../../src/data/constructors/path'

isT = R.is(T)
isObject = R.is(Object)
isPath = R.is(Path)
isString = R.is(String)

mapData = R.curry (localize, data) ->
  if R.or(isT(data), isPath(data))
    localize(data)
  else if isObject(data)
    R.mapObj(mapData(localize), data)


getLocaizer = R.curry (locals,language) ->
  localize = (format, args) ->
    args = args || []
    if isString(format)
      obj = locals[format]
    else
      obj = format

    if isPath(obj)
      value = obj.path
      args = [language.path].concat(args);
    else
      value = obj[language.code]

    if typeof value == 'undefined'
      #warn format is not set for default language
      gutil.log "T: unknown format #{format}";
      return "[[[#{format}]]]"

    if isString(value)
      return vsprintf(value,args) 
    else
      return value
  localize.language = language
  localize
  

log = (a)->
  console.log a
  a

module.exports = (languages, locals) ->
  mapData: mapData
  map: (f)->
    R.values(R.mapObj(R.compose(f, getLocaizer(locals)), languages))
