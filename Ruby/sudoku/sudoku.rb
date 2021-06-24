require_relative 'board'

class Sudoku
  def initialize(board)
    @board = board
  end

  def play_turn
    @board.render
    pos = get_pos
    value = get_value
    update_tile(pos, value)
  end

  def run
    play_turn until solved?
    @board.render
    puts 'Congratulations, you win!'
  end

  def solved?
    @board.solved?
  end

  def get_pos
    pos = nil
    until pos && valid_pos?(pos)
      puts 'Please enter a position on the board (ex. 0 0)'
      pos = gets.chomp.split(' ').map(&:to_i)
    end
    pos
  end

  def get_value
    value = nil
    until value && valid_value?(value)
      puts 'Please enter a value between 1 and 9'
      value = gets.chomp.to_i
    end
    value
  end

  def valid_pos?(pos)
    return false unless pos.all? { |num| num.between?(0, @board.size - 1) }
    return false unless pos.length == 2

    true
  end

  def valid_value?(value)
    value.between?(0, 9)
  end

  def update_tile(pos, value)
    @board[pos] = value
  end
end

board = Board.from_file('puzzles/sudoku1_almost.txt')
game = Sudoku.new(board)
game.run
