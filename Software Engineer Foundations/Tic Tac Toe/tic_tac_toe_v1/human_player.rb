class HumanPlayer

    attr_reader :mark

    def initialize(value)
        @mark = value
    end

    def get_position
        puts "----------------------"
        puts "Enter a move #{mark.to_s} (two numbers with a space between them like \'0 1\')"
        position = gets.chomp.split(' ').map(&:to_i)
        raise "Invalid move, try again" if position.length != 2
        position
    end
end