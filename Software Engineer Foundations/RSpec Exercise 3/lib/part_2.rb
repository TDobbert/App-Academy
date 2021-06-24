def element_count(array)
    count = Hash.new(0)
    array.each { |ele| count[ele] += 1}
    count
end

def char_replace!(string , hash)

    (0...string.length).each do |idx|
        if hash.has_key?(string[idx])
            string[idx] = hash[string[idx]]
        end
    end
    string
end

def product_inject(num_arr)
    num_arr.inject { |acc, ele| acc * ele}
end