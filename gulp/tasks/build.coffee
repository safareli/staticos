runSequence = require('run-sequence')
module.exports = (gulp, plugins, config)->
  gulp.task 'build', (cb)->
    cb()
    runSequence('clean',['scripts', 'htdocs', 'images', 'styles'],(->))