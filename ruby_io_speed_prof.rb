# frozen_string_literal: true

require 'memory_profiler'
require "vips"

ORIGINAL = "cakes.jpg"

SIZES = {
  large:  [800, 800],
  medium: [500, 500],
  small:  [300, 300],
}

start = Time.now

MemoryProfiler.start

SIZES.map do |size, (width, height)|
  Thread.new do
    name = size.to_s + ".jpg"
      Vips::Image.thumbnail(ORIGINAL, width).write_to_file(name)
  end
end.each(&:join)

report = MemoryProfiler.stop

stop = Time.now

puts "Took: #{((stop - start) * 1000).to_i}ms"

report.pretty_print(to_file: 'report_vips.txt')
