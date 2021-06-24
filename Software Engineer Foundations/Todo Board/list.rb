require './item.rb'

class List
    # print styles CONSTANTS
    INDEX_COL_WIDTH = 5
    DASH_WIDTH = 41
    TITLE_COL_WIDTH = 10
    DEADLINE_COL_WIDTH = 10
    CENTER = 12
    CHECKMARK = "\u2713".force_encoding('utf-8') # pretty checkmark

    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = '')
        return false if !Item.valid_date?(deadline)
        @items << Item.new(title, deadline, description)
        true
    end

    def size
        @items.length
    end

    def valid_index?(index)
        (0...self.size).any? {|i| i == index}
    end

    def swap(index_1, index_2)
        return false if !valid_index?(index_1) || !valid_index?(index_2)
        @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
        true
    end

    def [](index)
        return nil if !valid_index?(index)
        @items[index]
    end

    def print
        puts '-' * DASH_WIDTH 
        puts " " * CENTER + self.label.upcase
        puts '-' * DASH_WIDTH 
        puts "#{"Index".ljust(INDEX_COL_WIDTH)} | #{"Item".ljust(TITLE_COL_WIDTH)} | #{"Deadline".ljust(DEADLINE_COL_WIDTH)} | Done"
        puts '-' * DASH_WIDTH 
        @items.each_with_index do |item, i|
            status = item.done ? CHECKMARK : ' '
            puts "#{i.to_s.ljust(INDEX_COL_WIDTH)} | #{item.title.ljust(TITLE_COL_WIDTH)} | #{item.deadline.ljust(DEADLINE_COL_WIDTH)} | [#{status}]"
        end
        puts '-' * DASH_WIDTH 
    end

    def print_full_item(index)
        return false if !valid_index?(index)
        puts '-' * DASH_WIDTH 
        status = @items[index].done ? CHECKMARK : ' '
        puts "#{@items[index].title}".ljust(DASH_WIDTH/2) + "#{@items[index].deadline} [#{status}]".rjust(DASH_WIDTH/2)
        puts @items[index].description
        puts '-' * DASH_WIDTH 
    end

    def print_priority
        print_full_item(0)
    end

    def up(index, amount = 1)
        return false if !valid_index?(index)

        while amount > 0 && index != 0
            swap(index, index - 1)
            amount -= 1
            index -= 1
        end
        true
    end

    def down(index, amount = 1)
        return false if !valid_index?(index)

        while amount > 0 && index != size - 1
            swap(index, index + 1)
            index += 1
            amount -= 1
        end
        true
    end

    def sort_by_date!
        @items.sort_by! {|item| item.deadline}
    end

    def toggle_item(index)
        @items[index].toggle if !@items[index].nil?
    end

    def remove_item(index)
        return false if !valid_index?(index)
        @items.delete_at(index)
        true
    end

    def purge
        @items.delete_if(&:done)
    end

end