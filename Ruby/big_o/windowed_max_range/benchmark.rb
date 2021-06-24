require_relative 'windowed_max_range'
require_relative 'max_windowed_range'

require 'benchmark'

def performance_test(arr, window_size)
  Benchmark.benchmark(Benchmark::CAPTION, 14, Benchmark::FORMAT) do |x|
    x.report('Tot. naive: ') { windowed_max_range(arr, window_size) }
    x.report('Tot. mmsq: ') { max_windowed_range(arr, window_size) }
  end
end

def random_array(size)
  Array.new(size) { rand(100) }
end

def run_benchmarks
  sizes = [100, 1000, 10_000, 100_000, 1_000_000]
  sizes.each do |size|
    window_size = size / 100
    puts "Size: #{size}, window size: #{window_size}"
    performance_test(random_array(size), window_size)
    puts
  end
end

run_benchmarks
