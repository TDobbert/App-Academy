
def palindrome?(string)

    new_str = []
    i = string.length
    while i > -1
        new_str << string[i]
        i-=1
    end
    string == new_str.join("")
end

def substrings(string)
    subs = []

    (0...string.length).each do |first|
        (first...string.length).each do |last|
            subs << string[first..last]
        end
    end
    subs
end

def palindrome_substrings(string)
    substrings(string).select do |substr| 
        if substr.length > 1
            palindrome?(substr)
        end
    end
end