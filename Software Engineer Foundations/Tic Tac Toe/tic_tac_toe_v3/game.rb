require './board.rb'
require './human_player.rb'
require './computer_player.rb'

class Game

    def initialize(n, players)
        @players = players.map do |mark, computer| 
            if computer 
                ComputerPlayer.new(mark)
            else
                HumanPlayer.new(mark)
            end
        end
        @current_player = @players.first
        @board = Board.new(n)
    end

    def switch_turn
        @current_player = @players.rotate!.first
    end

    def play
        while @board.empty_positions?
            @board.print
            position = @current_player.get_position(@board.legal_positions)
            @board.place_mark(position, @current_player.mark)
            if @board.win?(@current_player.mark)
                puts "Game Over!"
                puts "#{@current_player.mark} is victorious!"
                return
            else
                switch_turn
            end
        end
        puts "Game Over!"
        puts "It's a draw!"
    end
end
