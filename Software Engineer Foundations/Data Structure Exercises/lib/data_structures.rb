# EASY

# Write a method that returns the range of its argument (an array of integers).
def range(arr)
  return arr.max - arr.min
end

# Write a method that returns a boolean indicating whether an array is in sorted
# order. Use the equality operator (==), which returns a boolean indicating
# whether its operands are equal, e.g., 2 == 2 => true, ["cat", "dog"] ==
# ["dog", "cat"] => false
def in_order?(arr)
  arr.sort == arr
end


# MEDIUM

# Write a method that returns the number of vowels in its argument
def num_vowels(str)
  str.downcase!
  return str.count("a") + str.count("e") + str.count("i") + str.count("o") +str.count("u")
end

# Write a method that returns its argument with all its vowels removed.
def devowel(str)
  str.delete!("a")
  str.delete!("A")
  str.delete!("e")
  str.delete!("E")
  str.delete!("i")
  str.delete!("I")
  str.delete!("o")
  str.delete!("O")
  str.delete!("u")
  str.delete!("U")
  return str
end


# HARD

# Write a method that returns the returns an array of the digits of a
# non-negative integer in descending order and as strings, e.g.,
# descending_digits(4291) #=> ["9", "4", "2", "1"]
def descending_digits(int)
  return int.to_s.split("").sort.reverse
end

# Write a method that returns a boolean indicating whether a string has
# repeating letters. Capital letters count as repeats of lowercase ones, e.g.,
# repeating_letters?("Aa") => true
def repeating_letters?(str)
  str.downcase.split("").uniq.length != str.length

end

# Write a method that converts an array of ten integers into a phone number in
# the format "(123) 456-7890".
def to_phone_number(arr)
  part_one = arr[0..2].join
  part_two = arr[3..5].join
  part_three = arr[6..9].join
  return "(" + part_one + ") " + part_two + "-" + part_three
end

# Write a method that returns the range of a string of comma-separated integers,
# e.g., str_range("4,1,8") #=> 7
def str_range(str)
  arr = str.split(",")
  arr.sort!
  return arr[-1].to_i - arr[0].to_i
end


#EXPERT

# Write a method that is functionally equivalent to the rotate(offset) method of
# arrays. offset=1 ensures that the value of offset is 1 if no argument is
# provided. HINT: use the take(num) and drop(num) methods. You won't need much
# code, but the solution is tricky!
def my_rotate(arr, offset=1)
  split = offset % arr.length
  return arr.drop(split) + arr.take(split)
end
