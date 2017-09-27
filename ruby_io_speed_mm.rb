# frozen_string_literal: true
require "mini_magick"

ORIGINAL = "cakes.jpg"

SIZES = {
  large:  [800, 800],
  medium: [500, 500],
  small:  [300, 300],
}

start = Time.now

SIZES.map do |size, (width, height)|
  Thread.new do
    name = size.to_s + ".jpg"
    MiniMagick::Image.open(ORIGINAL).resize("#{width}x#{height}").write(name)
  end
end.each(&:join)

stop = Time.now

puts "Took: #{((stop - start) * 1000).to_i}ms"
