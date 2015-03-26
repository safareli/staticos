GE2EN = ((set)->
  (string)->
    (Array::map.call string, (char)->
      set[char] || char).join('')
)({"ა":"a","ბ":"b","გ":"g","დ":"d","ე":"e","ვ":"v","ზ":"z","თ":"t","ი":"i","კ":"k'","ლ":"l","მ":"m","ნ":"n","ო":"o","პ":"p'","ჟ":"zh","რ":"r","ს":"s","ტ":"t'","უ":"u","ფ":"p","ქ":"k","ღ":"gh","ყ":"q","შ":"sh","ჩ":"ch","ც":"ts","ძ":"dz","წ":"ts'","ჭ":"ch'","ხ":"kh","ჯ":"j","ჰ":"h"})

module.exports = (marked)->
  renderer = new marked.Renderer()
  renderer.heading = (text, level) ->
    escapedText = GE2EN(text).toLowerCase().replace(/[^\w]+/g, "-")
    "<h#{level} id=\"#{escapedText}\">#{text}</h#{level}>"
  marked.setOptions renderer: renderer
  return marked;