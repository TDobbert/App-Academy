# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    def span
        if self.length > 0
            return self.max - self.min
        end
        nil
    end

    def average
        if self.length > 0 
            return self.sum.to_f / self.length
        end
        nil
    end

    def median

        return nil if self.empty?

        if self.length.odd?
            mid = self.length / 2
            return self.sort[mid]
        else
            mid = self.length / 2
            first_el = mid
            second_el = mid - 1
            return ((self.sort[first_el] + self.sort[second_el])).to_f / 2
        end
    end


    def counts
        el_count = Hash.new(0)

        self.each {|el| el_count[el] += 1}
        el_count
    end

    def my_count(arg)
        count = 0

        self.each do |el|
           if arg == el
               count +=1
           end
        end
        count
    end

    def my_index(arg)
        self.each.with_index do |el, idx|
            if arg == el
                return idx
            end
        end
        nil
    end

    def my_uniq
        hash = {}
        self.each {|ele| hash[ele] = true}
        hash.keys
    end

    def my_transpose
        new_arr = []

        (0...self.length).each do |row|
            new_row = []

            (0...self.length).each do |col|
                new_row << self[col][row]
            end
            new_arr << new_row
        end
        new_arr
    end
end