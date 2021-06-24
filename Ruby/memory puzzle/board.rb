require_relative "card"

class Board

    attr_reader :size, :grid

    def initialize(size = 4)
        @grid = Array.new(size) {Array.new(size)}
        @size = size
        populate
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, value)
        row, col = pos
        @grid[row][col] = value
    end

    #fill the board with a set of shuffled Card pairs
    def populate
        num_pairs = (size**2) / 2
        cards = Card.shuffled_pairs(num_pairs)
        @grid.each_index do |row|
            @grid[row].each_index do |col|
                 self[[row, col]] = cards.pop
            end
        end
    end

    #print out a representation of the Board's current state
    def render
        system("clear")
        puts "  #{(0...size).to_a.join(' ')}"
        @grid.each_with_index {|row, i| puts "#{i.to_s} #{row.join(" ")} "}
    end

    #return true if all cards have been revealed
    def won?
        @grid.all? {|cards| cards.all?(&:face_up)}
    end

    def hide(pos)
        self[pos].hide
    end

    def face_up?(pos)
        self[pos].face_up?
    end

    #reveal a Card at guessed_pos
    def reveal(pos)
        if face_up?(pos)
            puts "Card is already face up"
        else
        self[pos].reveal
        end
        self[pos].card_value
    end
end