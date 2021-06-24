require_relative "board"
require_relative "human_player"
require_relative "computer_player"

class Game

    attr_accessor :previous_guess
    attr_reader :board, :player

    def initialize(player, size = 4)
        @board = Board.new(size)
        @previous_guess = nil
        @player = player
    end

    def play
        until @board.won?
            system("clear")
            @board.render
            pos = get_player_input
            make_guess(pos)
        end

        puts "You win!"
    end

    def get_player_input
        pos = nil

        until pos && valid_play?(pos)
            pos = @player.get_input
        end
        pos
    end

    def make_guess(pos)
        revealed = @board.reveal(pos)
        @player.receive_revealed_card(pos, revealed)
        @board.render

        guess_comparison(pos)

        sleep(1)
        @board.render
    end

    def guess_comparison(current_guess)
        if previous_guess
            if is_match?(previous_guess, current_guess)
                player.receive_match(previous_guess,current_guess)
            else
                puts "Try again."
                hide_positions(previous_guess,current_guess)
            end
            self.previous_guess = nil
            player.previous_guess = nil
        else
            self.previous_guess = current_guess
            player.previous_guess = current_guess
        end
    end

    def hide_positions(previous_guess,current_guess)
        positions = [previous_guess, current_guess]
        positions.each {|pos| @board.hide(pos)}
    end

    def valid_play?(pos)
        return false if pos.length != 2
        return false if pos.none? {|num| num.between?(0, @board.size-1)}
        return false if board.face_up?(pos)
        true
    end

    def is_match?(previous_guess, current_guess)
        @board[previous_guess] == @board[current_guess]
    end
end

if $PROGRAM_NAME == __FILE__
  size = ARGV.empty? ? 4 : ARGV.shift.to_i
  Game.new(ComputerPlayer.new(size), size).play
end
