# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

def largest_prime_factor(num)

    num.downto(2) do | factor |
        if num % factor == 0 && prime?(factor)
            return factor
        end
    end
end

def prime?(num)    
    return false if num < 2

    (2...num).each do |factor|
        if num % factor == 0
            return false
        end
    end
    true
end

def unique_chars?(string)
    non_unique = []

    string.each_char do |char|
        if non_unique.include?(char)
            return false
        end
        non_unique << char
    end
    true
end

def dupe_indices(array)
    dupe_hash = Hash.new {|hash, key| hash[key] = []}

    array.each.with_index do |key, value|
        dupe_hash[key] << value
    end
    
    dupe_hash.select { |el, arr| arr.length > 1}
end

def ana_array(arr1, arr2)
    if ele_count(arr1) == ele_count(arr2)
        return true
    else
        return false
    end
end

def ele_count(ele)
    count = Hash.new(0)
    ele.each { |el| count[el] += 1 }
    return count
end