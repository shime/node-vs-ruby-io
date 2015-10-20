require "dotenv"
Dotenv.load!

require "aws-sdk"

aws_options = {
  access_key_id:     ENV.fetch("ACCESS_KEY_ID"),
  secret_access_key: ENV.fetch("SECRET_ACCESS_KEY"),
  region:            ENV.fetch("REGION"),
}

bucket_name = ENV.fetch("BUCKET")

s3 = Aws::S3::Resource.new(aws_options)
bucket = s3.bucket(bucket_name)

require "image_processing/mini_magick"
include ImageProcessing::MiniMagick

require "open-uri"
require "benchmark"

start = Time.now.to_f
file = open("http://www.planwallpaper.com/static/images/2022725-wallpaper_625864_Iz6NK8G.jpg")

version_800 = resize_to_limit!(file, 800, 800)
version_500 = resize_to_limit(version_800, 500, 500)
version_300 = resize_to_limit(version_500, 300, 300)

bucket.object("large.jpg").put(body: version_800)
bucket.object("medium.jpg").put(body: version_500)
bucket.object("small.jpg").put(body: version_300)

puts "Took: #{((Time.now - start).to_f * 1000).to_i}ms"
