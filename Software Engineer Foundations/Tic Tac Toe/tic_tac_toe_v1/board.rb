class Board

    def initialize
        @grid = Array.new(3) {Array.new(3, '_')}
    end

    def [](position)
        row, col = position
        @grid[row][col]
    end

    def []=(position, value)
        row, col = position
        @grid[row][col] = value
    end

    def valid?(position)
        row, col = position
        position.all? do |i|
            0 <= i && i < @grid.length
        end
    end

    def empty?(position)
        self[position] == '_'
    end

    def place_mark(position, mark)
        if !valid?(position) || !empty?(position)
            raise "invalid mark!"
        end
        self[position] = mark
    end

    def print
        puts "Tic Tac Toe"
        puts "-----------"
        @grid.each {|row| puts row.join(" ")}
        puts "-----------"
    end

    def win_row?(mark)
        @grid.any? {|row| row.all?(mark)}
    end

    def win_col?(mark)
        @grid.transpose.any? {|col| col.all?(mark)}
    end

    def win_diagonal?(mark)
        #left diagonal
        left = (0...@grid.length).all? do |i| 
            position = [i,i]
            self[position] == mark
        end

        #right diagonal
        right = (0...@grid.length).all? do |i|
            row = i
            col = @grid.length - 1 - i
            position = [row, col]
            self[position] == mark
        end

        left || right
    end

    def win?(mark)
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        @grid.flatten.any? {|pos| pos == '_'}
    end
end
