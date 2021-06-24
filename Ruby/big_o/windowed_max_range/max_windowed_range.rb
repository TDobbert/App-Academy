require_relative 'min_max_stack_queue'

def max_windowed_range(arr, window_size)
  queue = MinMaxStackQueue.new
  current_max_range = 0

  arr.each do |ele|
    queue.enqueue(ele)
    queue.dequeue if queue.size > window_size

    if queue.size == window_size
      range = queue.max - queue.min
      current_max_range = range if current_max_range < range
    end
  end
  current_max_range
end

p max_windowed_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p max_windowed_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p max_windowed_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p max_windowed_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
