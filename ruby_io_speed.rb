require "dotenv"
Dotenv.load!

require "image_processing/mini_magick"
include ImageProcessing::MiniMagick

start = Time.now.to_f
file = File.open("bridge.jpg")

version_800 = resize_to_limit!(file, 800, 800)
version_500 = resize_to_limit(version_800, 500, 500)
version_300 = resize_to_limit(version_500, 300, 300)

File.write("large.jpg", version_800)
File.write("medium.jpg", version_500)
File.write("small.jpg", version_300)

puts "Took: #{((Time.now - start).to_f * 1000).to_i}ms"
