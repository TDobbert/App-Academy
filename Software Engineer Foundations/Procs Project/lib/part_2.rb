require "byebug"

def reverser(string, &prc)
    prc.call(string.reverse)
end

def word_changer(sentence, &prc)
    new_sentence = ""
    sentence_arr = sentence.split(" ")

    new_sentence = sentence_arr.map {|word| prc.call(word)}
    new_sentence.join(" ")
end

def greater_proc_value(num, proc_1, proc_2)
    if proc_1.call(num) > proc_2.call(num)
        proc_1.call(num)
    else
        proc_2.call(num)
    end
end

def and_selector(array, proc_1, proc_2)
    new_arr = []

    array.each do |num|
        if proc_1.call(num) == true && proc_2.call(num) == true
            new_arr <<  num
        end
    end
    new_arr
end

def alternating_mapper(array, proc_1, proc_2)
    array.map.with_index do |num, index|
        if index.even?
            proc_1.call(num)
        else
            proc_2.call(num)
        end
    end
end