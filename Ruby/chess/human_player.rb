require_relative 'display'
require_relative 'player'

class HumanPlayer < Player
  def make_move
    start_pos = get_pos
    end_pos = get_pos
    [start_pos, end_pos]
  end

  def get_pos
    pos = nil
    until pos
      display.render
      puts "#{color}'s turn"
      pos = display.cursor.get_input
    end
    pos
  end
end
