class HumanPlayer

    attr_reader :mark

    def initialize(value)
        @mark = value
    end

    def get_position(legal_positions)
        position = nil
        until legal_positions.include?(position)
            puts "----------------------"
            puts "Enter a move #{mark.to_s} (two numbers with a space between them like \'0 1\')"
            position = gets.chomp.split(' ').map(&:to_i)
            puts "#{position} is not legal" if !legal_positions.include?(position)
            raise "Invalid move, try again" if position.length != 2
        end
        position
    end
end
