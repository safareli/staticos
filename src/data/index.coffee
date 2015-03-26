{t, path, person} = require './constructors'
T = require './constructors/t'

module.exports = 
  data:
    me: person(t('ირაკლი', 'Irakli'), t('საფარელი', 'Safareli'))
  locals:
    logo: path('%s/logo.png')
    title: t('ვაუ სათაური', 'WoW title')

console.log(module.exports instanceof Object)
# console.log(JSON.stringify(module.exports, null, 2))