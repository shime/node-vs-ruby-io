var sharp = require('sharp')
var async = require('async')
var fs = require('fs')

sharp.simd(true);

var SIZES = {
  large: [800, 800],
  medium: [500, 500],
  small: [300, 300],
}

var performUpload = function(size, next){
  var name = size + ".jpg"
  var resizer = function(){
    var client = sharp()
    return client.resize.
      apply(client, [SIZES[size][0]])
  }

  var stream = image.pipe(resizer(size)).pipe(fs.createWriteStream(name))
  stream.on("close", next)
}

console.time('Took')
var image = fs.createReadStream('cakes.jpg')
async.map(Object.keys(SIZES), performUpload, function(err, pics){
  if (err) throw err

  console.timeEnd('Took')
})
