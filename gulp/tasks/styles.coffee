nib = require("nib")
module.exports = (gulp, plugins, config)->
  gulp.task 'styles', ->
    sourcemap = if config.isDevelopment then (
      inline: true
      sourceRoot: ".."
      basePath: "css"
    ) else false
    return gulp.src(config.dir.src.styles + "style.styl")
      .on "error", config.logger.error
      .pipe plugins.plumber()
      .pipe plugins.stylus
        use: [nib()]
        compress: config.isProduction
        sourcemap: sourcemap
      .pipe gulp.dest(config.dir.build.base)
      .pipe plugins.connect.reload()
