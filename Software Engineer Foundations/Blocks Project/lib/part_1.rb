#include byebug

def select_even_nums(num_arr)
    num_arr.select {|num| num.even?}
end

def reject_puppies(dog_arr)
    dog_arr.reject {|dogs| dogs["age"] < 3}
end

def count_positive_subarrays(twod_arr)
    twod_arr.count {|sub_arr| sub_arr.sum > 0}
end

def aba_translate(string)
    vowels = "aeiou"
    new_str = ""

    string.each_char do |char|
        if vowels.include?(char)
            new_str += char + "b" + char
        else
            new_str += char
        end
    end
        new_str
end

def aba_array(words_arr)
    words_arr.map {|word| aba_translate(word)}
end
