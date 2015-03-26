requireDir        = require('require-dir')
requireUncached   = require('require-uncached')
gulp              = require('gulp')
runSequence       = require('run-sequence').use(gulp)
plugins           = require('gulp-load-plugins')({
  camelize: true,
  lazy: true
})
isDevelopment = process.argv[2] == undefined

addLocalsToConfig = (path,config) ->
  config.updateLocals = ()->
    locals = requireUncached(path + 'index')
    config.data = locals.data
    config.locals = locals.locals
    config.language = requireUncached(path + "language")
    
  config.updateLocals()
  return config

config = addLocalsToConfig '../src/data/',
  isWatching: isDevelopment
  isDevelopment: isDevelopment
  isProduction: !isDevelopment
  logger: require('./util/logger')
  dir:
    src:
      base: './src'
      styles: './src/styles/'
      images: './src/images/'
      htdocs: './src/htdocs/'
      scripts: './src/scripts/'
      locals: './src/locals/'
    build: 
      base: './build'
      images: '/images/'
      script: 'app.js'

for name, task of requireDir('tasks')
  task(gulp,plugins,config)


gulp.task('default', ['watch'])