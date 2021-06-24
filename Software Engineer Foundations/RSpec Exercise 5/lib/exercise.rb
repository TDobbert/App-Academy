def zip(*arrays)
    (0...arrays[0].length).map do |i|
         arrays.map {|array| array[i]}
    end
end

def prizz_proc(array, prc1, prc2)
    array.select {|ele| ele if prc1.call(ele) && !prc2.call(ele) || !prc1.call(ele) && prc2.call(ele)}
end

def zany_zip(*arrays)
    length = arrays.map(&:length).max

    (0...length).map do |i|
         arrays.map {|array| array[i]}
    end
end

def maximum(array, &prc)
    return nil if array.empty?
    max = array.first
    array.each do |el|
        max = el if prc.call(el) >= prc.call(max)
    end
    max
end

def my_group_by(array, &prc)
    group = Hash.new {|h,k| h[k] = []}
    array.each do |ele|
        group[prc.call(ele)] << ele
    end
    group
end

def max_tie_breaker(array, proc, &prc)
    return nil if array.empty?
    max = array.first
    array.each do |el|
        if prc.call(el) == prc.call(max) && proc.call(el) > proc.call(max)
            max = el
        elsif prc.call(el) > prc.call(max)
            max = el 
        end
    end
    max
end

def change_word(word)
    indices = vowel_indices(word)
    word[indices[0]..indices[-1]]
end

def vowel_indices(word)
    vowels = 'aeiou'
    indices = []
    (0...word.length).each do |i|
        indices << i if vowels.include?(word[i])
    end
    indices
end

def silly_syllables(sentence)
    words = sentence.split(" ")
    new_words = words.map do |word|
        num_vowels = vowel_indices(word).length
        if num_vowels < 2
            word
        else
            change_word(word)
        end
    end
    new_words.join(" ")
end
