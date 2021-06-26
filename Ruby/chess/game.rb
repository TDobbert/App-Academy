require_relative 'board'
require_relative 'human_player'
require 'byebug'

class Game
  attr_reader :board, :display, :players, :current_player
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {
      white: HumanPlayer.new(:white, @display),
      black: HumanPlayer.new(:black, @display)
    }
    @current_player = :white
  end

  def play
    until board.checkmate?(current_player)
      begin
        start_pos, end_pos = players[current_player].make_move
        board.move_piece(current_player, start_pos, end_pos)
        switch_player
        notify_players
      rescue StandardError => e
        @display.notifications[:error] = e.message
        retry
      end
    end

    display.render
    puts "Checkmate! #{current_player}"
    nil
  end

  def notify_players
    if board.in_check?(current_player)
      display.check
    else
      display.uncheck
    end
  end

  def switch_player
    @current_player = (current_player == :white ? :black : :white)
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new.play
end
