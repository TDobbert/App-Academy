require "byebug"

def all_words_capitalized?(words_arr)
    words_arr.all? {|word| word.capitalize == word}
end

def no_valid_url?(url_arr)
    valid_end = ['.com', '.net', '.io', '.org']
    
    url_arr.none? do |url|
        valid_end.any? {|ending| url.end_with?(ending)}
    end
end

def any_passing_students?(student_arr)
    student_arr.any? {|student| average(student[:grades]) >= 75}
end

def average(arr)
    arr.sum / arr.length
end