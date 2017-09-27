require 'thread'

# Credits: http://zogovic.com/post/59091704817/memory-usage-monitor-in-ruby

class MemoryUsageMonitor
  attr_reader :peak_memory, :log

  def initialize(frequency: 0.25)
    @frequency = frequency
    @peak_memory = 0
    @log = []
  end

  def start
    @thread = Thread.new do
      while true do
        puts "#{Process::pid}"
        memory = `ps -o rss -p #{Process::pid}`.chomp.split("\n").last.strip.to_i
        @log.push memory
        @peak_memory = [memory, @peak_memory].max
        sleep @frequency
      end
    end
  end

  def stop
    Thread.kill(@thread)
  end
end
