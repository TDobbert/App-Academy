def is_prime?(num)
    return false if num < 2

    (2...num).each do |n|
        if num % n == 0
            return false
        end
    end
    true
end

def nth_prime(n)
    count = 0
    num = 1

    while count < n
        num += 1
        count += 1 if is_prime?(num)
    end
    num
end

def prime_range(min, max)
    range = []

    (min..max).each do |num|
        range << num if is_prime?(num)
    end
    range
end