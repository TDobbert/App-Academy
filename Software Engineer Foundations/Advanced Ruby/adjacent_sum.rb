#Write a method adjacent_sum that takes in an array of numbers and returns a new
#array containing the sums of adjacent numbers in the original array. See the 
#examples.

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

print adjacent_sum([3, 7, 2, 11]) #=> [10, 9, 13], because [ 3+7, 7+2, 2+11 ]
puts
print adjacent_sum([2, 5, 1, 9, 2, 4]) #=> [7, 6, 10, 11, 6], because [2+5, 5+1, 1+9, 9+2, 2+4]
puts