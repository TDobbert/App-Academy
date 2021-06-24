def my_min1(list)
  min = 0
  list.each do |num1|
    list.each do |num2|
      min = num1 if num1 < num2 && num1 < min
    end
  end
  min
end

def my_min2(list)
  min = list.first
  list.each { |num| min = num if num < min }
  min
end

def largest_contiguous_subsum1(list)
  sub_arrs = []

  list.each_index do |i1|
    (i1..list.length - 1).each do |i2|
      sub_arrs << list[i1..i2]
    end
  end
  sub_arrs.map { |subs| subs.inject(:+) }.max
end

def largest_contiguous_subsum2(list)
  current = list.first
  largest = list.first

  (1...list.length).each do |i|
    current = 0 if current.negative?
    current += list[i]
    largest = current if current > largest
  end
  largest
end

list1 = [0, 3, 5, 4, -5, 10, 1, 90]
list2 = [2, 3, -6, 7, -6, 7]
list3 = [-5, -1, -3]

p largest_contiguous_subsum2(list3) # => -1 (from [-1])
p largest_contiguous_subsum1(list2) # => 8 (from [7, -6, 7])
p my_min1(list1)  # =>  -5
p my_min2(list1)  # =>  -5
