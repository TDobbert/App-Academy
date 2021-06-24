def windowed_max_range(arr, window_size)
  current_max_range = 0

  (0..arr.length - window_size).each do |i|
    window = arr[i...i + window_size]
    range = window.max - window.min
    current_max_range = range if current_max_range < range
  end
  current_max_range
end

p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
