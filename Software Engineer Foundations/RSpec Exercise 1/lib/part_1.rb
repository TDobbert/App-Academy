#/lib/part_1.rb

def average(num1, num2)
    (num1.to_f + num2.to_f) / 2
end

def average_array(num_arr)
    num_arr.sum.to_f / num_arr.length
end

def repeat(str, num)
    str * num
end

def yell(str)
    str.upcase + "!"
end

def alternating_case(sent)
    words = sent.split(" ")

  new_words = words.map.with_index do |word, idx|
    if idx.even?
      word.upcase
    else
      word.downcase
    end
  end

  new_words.join(" ")
end
