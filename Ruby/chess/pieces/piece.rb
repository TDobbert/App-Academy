class Piece
  attr_reader :board, :color
  attr_accessor :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos

    board.add_piece(self, pos)
  end

  def to_s
    " #{symbol} "
  end

  def empty?
    false
  end

  def valid_moves
    moves.reject { |pos| move_into_check?(pos) }
  end

  def symbol
    raise NotImplementedError
  end

  def move_into_check?(end_pos)
    board_dup = board.dup
    board_dup.move_piece!(pos, end_pos)
    board_dup.in_check?(color)
  end
end
