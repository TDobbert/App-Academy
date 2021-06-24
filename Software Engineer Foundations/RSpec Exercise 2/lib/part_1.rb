def partition(array, num)
    arr1 = []
    arr2 = []
    array.each do |n|
        if n < num
            arr1 << n
        else
            arr2 << n
        end
    end
     [arr1, arr2]
end

def merge(hash1, hash2)
    hash3 = Hash.new(0)

    hash1.each { |k1, v1| hash3[k1] = v1}
    hash2.each { |k2, v2| hash3[k2] = v2}
    hash3
end

def censor(sentence, curse_arr)
    words = sentence.split(" ")
    
    new_sentence = words.map do |word|
        if curse_arr.include?(word.downcase)
            star_censor(word)
        else
            word
        end
    end
    new_sentence.join(" ")
end

def star_censor(string)
    vowels = "aeiou"
    censored_word = ""

    string.each_char do |char|
        if vowels.include?(char.downcase)
            censored_word += "*"
        else
            censored_word += char
        end
    end
        censored_word

end

def power_of_two?(num)
    product = 1

    while product < num
        product *= 2
    end
    product == num
end
