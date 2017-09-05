var sharp = require('sharp')
var async = require('async')

sharp.simd(true);

var SIZES = {
  large: [800, 800],
  medium: [500, 500],
  small: [300, 300],
}

var performUpload = function(size, next){
  var name = size + ".jpg"
  sharp('cakes.jpg')
    .resize(SIZES[size][0], SIZES[size][1])
    .toFile(name, next);
}

console.time('Took')

async.map(Object.keys(SIZES), performUpload, function(err, pics){
  if (err) throw err

  console.timeEnd('Took')
})
