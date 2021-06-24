require_relative "board"
require_relative "player"

class Battleship

    attr_reader :board, :player

    def initialize(n)
        @player = Player.new
        @board = Board.new(n) 
        @remaining_misses = @board.size / 2
    end

    def start_game
        @board.place_random_ships
        puts "Number of ships #{@board.num_ships}"
        @board.print
    end

    def lose?
        if @remaining_misses <= 0
            puts "you lose"
            return true
        end
        false
    end

    def win?
        if @board.num_ships == 0
            puts "you win"
            return true
        end
        false
    end

    def game_over?
        if self.win? || self.lose?
            return true
        end
        false
    end

    def turn
        move = @player.get_move

        if @board.attack(move) == false
            @remaining_misses -= 1
        else
            @remaining_misses
        end

        board.print
        puts "remaining misses: #{@remaining_misses}"
    end
end
