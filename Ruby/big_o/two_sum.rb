require 'byebug'

def bad_two_sum?(arr, target_sum)
  arr.each_with_index do |num1, i1|
    arr.each_with_index do |num2, i2|
      return true if num1 + num2 == target_sum && i2 > i1
    end
  end
  false
end

def okay_two_sum?(arr, target_sum)
  sorted = arr.sort
  y = 0
  x = sorted.length - 1

  while y < x
    case sorted[y] + sorted[x] <=> target_sum
    when 0
      return true
    when -1
      y += 1
    when 1
      x -= 1
    end
  end
  false
end

def best_two_sum(arr, target_sum)
  map = {}

  arr.each do |el|
    # check if the difference exists in the map hash
    return true if map[target_sum - el]

    map[el] = true
  end

  false
end

arr = [1, 0, 5, 7, 2]
p best_two_sum(arr, 6)
p best_two_sum(arr, 10)
