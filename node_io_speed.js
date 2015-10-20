require('dotenv').load()

var sharp = require('sharp')
var AWS = require('aws-sdk')
var s3stream = require('s3-upload-stream')
var request = require('request')
var async = require('async')

var SIZES = {
  large: [800, 800],
  medium: [500, 500],
  small: [300, 300],
}
var URL = "http://www.planwallpaper.com/static/images/2022725-wallpaper_625864_Iz6NK8G.jpg"

AWS.config.update({
  "accessKeyId": process.env.ACCESS_KEY_ID,
  "secretAccessKey": process.env.SECRET_ACCESS_KEY,
  "region": process.env.REGION
})
s3stream.client(new AWS.S3())

var performUpload = function(size, next){
  var name = size + ".jpg"
  var upload   = new s3stream.upload({
    "Bucket":       process.env.BUCKET,
    "Key":          name,
    "ACL":          "public-read"
  })
  var resizer = function(){
    var client = sharp()
    return client.resize.
      apply(client, SIZES[size]).max()
  }

  upload.on('error', next)
  upload.on('uploaded', function(){ next(null) })

  image.pipe(resizer(size)).pipe(upload)
}

console.time('Took')
var image = request(URL)
async.map(Object.keys(SIZES), performUpload, function(err, pics){
  if (err) throw err

  console.timeEnd('Took')
})
