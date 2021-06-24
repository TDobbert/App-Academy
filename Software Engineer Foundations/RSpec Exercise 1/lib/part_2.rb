def hipsterfy(word)
    
    vowels = "aeiou"

    i = word.length - 1
    while i >= 0
        if vowels.include?(word[i])
        return word[0...i] + word[i+1..-1]
        end
        i -= 1
    end
    word
end

def vowel_counts(str)
    
    counter = Hash.new(0)
    vowels = "aeiou"

    str.downcase.each_char do |char|
        if vowels.include?(char)
            counter[char] += 1
        end
    end
    counter
end

def caesar_cipher(message, num)
   
    alpha = "abcdefghijklmnopqrstuvwxyz"
    cipher = ""

    message.each_char do |char|
        old_idx = alpha.index(char)
        if old_idx == nil
            cipher += char
        else
            new_idx = old_idx + num
            cipher += alpha[new_idx % 26]
        end
    end
   cipher
end
