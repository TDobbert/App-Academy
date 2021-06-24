def range(start_range, end_range)
  return [] if end_range <= start_range

  range(start_range, end_range - 1) << end_range - 1
end

def exp(base, pow)
  pow.zero? ? 1 : (base * exp(base, pow - 1))
end

def exp_two(base, pow)
  return 1 if pow.zero?

  half = exp_two(base, pow / 2)

  pow.even? ? half * half : base * half * half
end

class Array
  def deep_dup
    map { |el| el.is_a?(Array) ? el.deep_dup : el }
  end
end

def fib_rec(num)
  return [] if num == 0
  return [0] if num == 1
  return [0, 1] if num == 2

  seq = fib_rec(num - 1)
  seq << seq[-2] + seq[-1]
  seq
end

def fib_iter(num)
  return [] if num.zero?
  return [0] if num == 1

  fib = [0, 1]

  (0...num - 2).each do |i|
    temp = fib[i] + fib[i + 1]
    fib << temp
  end
  fib
end

def bsearch(num_arr, target)
  return nil if num_arr.empty?

  mid_index = num_arr.length / 2
  case target <=> num_arr[mid_index]
  when -1
    bsearch(num_arr.take(mid_index), target)
  when 0
    mid_index
  when 1
    sub_answer = bsearch(num_arr.drop(mid_index + 1), target)
    sub_answer.nil? ? nil : (mid_index + 1) + sub_answer
  end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

class Array
  def merge_sort
    unsorted = self
    return self if unsorted.length < 2

    middle = unsorted.length / 2

    left, right = unsorted.take(middle), unsorted.drop(middle)
    sorted_left, sorted_right = left.merge_sort, right.merge_sort

    merge(sorted_left, sorted_right)
  end

  def merge(left, right)
    merged_arr = []
    until left.empty? || right.empty?
      merged_arr << (left.first < right.first ? left.shift : right.shift)
    end

    merged_arr + left + right
  end

  def subsets
    sets = self
    return [[]] if sets.empty?

    subs = sets.take((sets.length - 1)).subsets
    large_subs = subs.map { |sub| sub + [sets.last] }
    subs + large_subs
  end
end

# p [].subsets # => [[]]
# p [1].subsets # => [[], [1]]
# p [1, 2].subsets # => [[], [1], [2], [1, 2]]
# p [1, 2, 3].subsets
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

def permutations(array)
  return [array] if array.length <= 1

  first = array.shift

  perms = permutations(array)
  all_perms = []

  perms.each do |perm|
    (0..perm.length).each do |i| 
      all_perms << perm[0...i] + [first] + perm[i..-1]
    end
  end
  all_perms
end

# p permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2],
#                           #     [2, 1, 3], [2, 3, 1],
#                           #     [3, 1, 2], [3, 2, 1]]

def make_change(amount, coins)
  return [] if amount.zero? || coins.empty?

  change = []

  coins.each do |coin|
    next if coin > amount

    remainder = amount - coin
    change << [coin] + make_change(remainder, coins)
  end
  change.min_by(&:length)
end

p make_change(24, [10, 7, 1])
