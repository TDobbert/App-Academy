#Write a method pyramid_sum that takes in an array of numbers representing the 
#base of a pyramid. The function should return a 2D array representing a complete 
#pyramid with the given base. To construct a level of the pyramid, we take the sum
#of adjacent elements of the level below.

# For example, the base [1, 4, 6] gives us the following pyramid
#     15
#   5   10
# 1   4    6

def pyramid_sum(base)
  sumArr = [base]
  
  while sumArr.length < base.length
    bottom = sumArr[0]
    nextLevel = adjacent_sum(bottom)
    sumArr.unshift(nextLevel)
  end
  
  return sumArr
end

def adjacent_sum(arr)
newArr = []
i = 0

while i < arr.length 
  if i != arr.length - 1
	newArr << arr[i] + arr[i + 1]
  elsif i == arr.length

end
	i += 1
end
return newArr
end

print pyramid_sum([1, 4, 6]) #=> [[15], [5, 10], [1, 4, 6]]
puts

print pyramid_sum([3, 7, 2, 11]) #=> [[41], [19, 22], [10, 9, 13], [3, 7, 2, 11]]
puts