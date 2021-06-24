#Write a method prime_factors that takes in a number and 
#returns an array containing all of the prime factors of 
#the given number.




def prime_factors(num)
  #initialize an array
  primeFacts = []
  
  #iterate each number from 1 until num
  (1..num).each do |nums|
    #if the remainder is 0 and nums is prime push nums
    if num % nums == 0 && prime?(nums)
      primeFacts << nums
    end
  end
  return primeFacts
end

def prime?(num)
  if num < 2
    return false
  end
  
  i = 2
  while i < num
    if num % i == 0
      return false
    end
    i += 1
  end
  return true
end

print prime_factors(24) #=> [2, 3]
puts
print prime_factors(60) #=> [2, 3, 5]
puts