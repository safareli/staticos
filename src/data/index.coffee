{t, path, asset, person} = require './constructors'
requireUncached   = require('require-uncached')
language = requireUncached './language'
T = require './constructors/t'

module.exports = 
  data:
    me: person(t('ირაკლი', 'Irakli'), t('საფარელი', 'Safareli'))
  locals:
    logo: asset('/images/general/%s/logo.png')
    blog: t('ბლოგი','blog')
    blogURL: path('/blog/')
    title: t('ვაუ სათაური', 'WoW title')
    nextLanguage: t('english', 'ქართული')
    nextLanguageURL: t(language.secondary.url,language.primary.url)

# console.log(JSON.stringify(module.exports, null, 2))