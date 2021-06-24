class Array

    def my_each(&prc)
        self.length.times {|i| prc.call(self[i])}
        self
    end

    def my_select(&prc)
        selected = []
        self.my_each {|i| selected << i if prc.call(i)}
        selected
    end

    #a = [1, 2, 3]
    #p a.my_select { |num| num > 1 } # => [2, 3]
    #p a.my_select { |num| num == 4 } # => []

    def my_reject(&prc)
        not_rejected = []
        self.my_each {|i| not_rejected << i if !prc.call(i)}
        not_rejected
    end

    #a = [1, 2, 3]
    #p a.my_reject { |num| num > 1 } # => [1]
    #p a.my_reject { |num| num == 4 } # => [1, 2, 3]

    def my_any?(&prc)
        self.my_each {|i| return true if prc.call(i)}
        false
    end

    #a = [1, 2, 3]
    #p a.my_any? { |num| num > 1 } # => true
    #p a.my_any? { |num| num == 4 } # => false

    def my_all?(&prc)
        self.my_each {|i| return false if !prc.call(i)}
        true
    end

    #a = [1, 2, 3]
    #p a.my_all? { |num| num > 1 } # => false
    #p a.my_all? { |num| num < 4 } # => true

    def my_flatten(array = [])
        flattened = []
        self.my_each do |el|
            if el.is_a?(Array)
                flattened += el.my_flatten
            else
                flattened << el
            end
        end
        flattened
    end

    #p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

    def my_zip(*arrays)
        zipped = []
        self.length.times do |i|
            subzip = [self[i]]
            arrays.my_each {|array| subzip << array[i]}
            zipped << subzip
        end
        zipped
    end

    #a = [ 4, 5, 6 ]
    #b = [ 7, 8, 9 ]
    #p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
    #p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
    #p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
    #
    #c = [10, 11, 12]
    #d = [13, 14, 15]
    #p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

    def my_rotate(pos = 1)
        rotated = []
        
        self.length.times {|i| rotated << self[(i + pos) % self.length]}
        rotated
    end

    #a = [ "a", "b", "c", "d" ]
    #p a.my_rotate         #=> ["b", "c", "d", "a"]
    #p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
    #p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
    #p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

    def my_join(seperator = "")
        joined = ""

        self.length.times do |i|
            joined += self[i]
            joined += seperator if i < self.length - 1
        end
        joined
    end

    #a = [ "a", "b", "c", "d" ]
    #p a.my_join         # => "abcd"
    #p a.my_join("$")    # => "a$b$c$d"

    def my_reverse
        reversed = []
        self.my_each {|el|reversed.unshift(el)}
        reversed
    end

    #p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
    #p [ 1 ].my_reverse               #=> [1]

end