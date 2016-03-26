require "vips8"
SIZES = {
  large:  [800, 800],
  medium: [500, 500],
  small:  [300, 300],
}

image = Vips::Image.new_from_file("bridge.jpg")
start = Time.now.to_f
threads = []


SIZES.each do |size, (width, height)|
    threads << Thread.new {
      factor = image.width.to_f / width
      filename = size.to_s + ".jpg"
      image.shrink(factor, factor).write_to_file(filename)
    }
end

threads.each(&:join)
puts "Took: #{((Time.now - start).to_f * 1000).to_i}ms"
