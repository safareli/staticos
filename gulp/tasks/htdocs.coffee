es = require('event-stream')
localizer = require('../util/localizer')
merge = require('merge')
fs = require 'fs'
path = require 'path'

marked = require("marked")
slagifier = require("../util/slagifier")
slagifier(marked)


R = require 'ramda'

log = (a)->
  console.log a
  a
module.exports = (gulp, plugins, config)->
  gulp.task 'htdocs', ->
    
    stream = gulp.src(config.dir.src.htdocs + "index.jade")
      .on "error", config.logger.error
      .pipe plugins.plumber()
    i18n = localizer(config.language, config.locals)
    mapDataWithLocalize = i18n.mapData(R.__ , config.data)
    files = i18n.map (localize)->
      data = mapDataWithLocalize(localize)
      stream
        .pipe plugins.clone()
        .pipe plugins.jade
          pretty: config.idDevelopment
          locals: merge true, data,
            t: localize
            imagePath: (baseDir,image)->
              path.join(config.dir.build.images, baseDir, localize(image))
            md:(filePath)->
              fullFilePath = path.join(config.dir.src.htdocs,filePath)
              contents = fs.readFileSync(fullFilePath,'utf8')
              marked(contents)
        .pipe plugins.rename
          dirname: localize.language.path
    return es.merge.apply(es,files)
      .pipe(gulp.dest(config.dir.build.base))
      .pipe plugins.connect.reload()