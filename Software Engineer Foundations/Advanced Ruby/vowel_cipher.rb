#Write a method vowel_cipher that takes in a string and returns a new string where
#every vowel becomes the next vowel in the alphabet.

def vowel_cipher(string)
  vowels = "aeiou"

    splitStr = string.split("").map do |char|
	  if vowels.include?(char)
        oldIdx = vowels.index(char)
        newIdx = oldIdx + 1
        vowels[newIdx % vowels.length]
      else
        char
      end
    end
  return splitStr.join("")
end

puts vowel_cipher("bootcamp") #=> buutcemp
puts vowel_cipher("paper cup") #=> pepir cap