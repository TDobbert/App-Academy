#Write a method consonant_cancel that takes in a sentence and returns a new 
#sentence where every word begins with it's first vowel.

def consonant_cancel(sentence)

  arr = sentence.split(" ").map do |word|
    removeConsonant(word)
  end
  return arr.join(" ")
end

def removeConsonant(word)
  vowels = "aeiou"
  
  word.each_char.with_index do |char, i|
    if vowels.include?(char)
      return word[i..-1]
    end
  end
end

puts consonant_cancel("down the rabbit hole") #=> "own e abbit ole"
puts consonant_cancel("writing code is challenging") #=> "iting ode is allenging"