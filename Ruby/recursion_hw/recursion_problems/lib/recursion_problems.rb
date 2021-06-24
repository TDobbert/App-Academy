# Problem 1:

def sum_recur(array)
  return 0 if array.empty?

  array.pop + sum_recur(array)
end

# Problem 2:

def includes?(array, target)
  return true if array.pop == target
  return false if array.empty?

  includes?(array, target)
end

# Problem 3:

def num_occur(array, target)
  count = 0
  return count if array.empty?

  count += 1 if array.pop == target
  count + num_occur(array, target)
end

# Problem 4:

def add_to_twelve?(array)
  return false if array.length == 1
  return true if array[-2] + array.pop == 12

  add_to_twelve?(array)
end

# Problem 5:

def sorted?(array)
  return true if array.length == 1
  return false if array[-2] > array.pop

  sorted?(array)
end

# Problem 6:

def reverse(string)
  return '' if string.empty?

  reverse(string[1..-1]) + string[0]
end
