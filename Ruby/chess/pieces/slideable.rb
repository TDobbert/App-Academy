module Slideable
  HORIZONTAL_AND_VERTICAL_DIRS = [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1]
  ].freeze

  DIAGONAL_DIRS = [
    [-1, -1],
    [1, 1],
    [1, -1],
    [-1, 1]
  ].freeze

  def horizontal_and_vertical_dirs
    HORIZONTAL_AND_VERTICAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    moves = []
    move_dirs.each { |dx, dy| moves += grow_unblocked_moves_in_dir(dx, dy) }
    moves
  end

  def move_dirs
    raise NotImplementedError
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    cur_x, cur_y = pos
    moves = []
    loop do
      cur_x += dx
      cur_y += dy
      pos = [cur_x, cur_y]
      break unless board.valid_pos?(pos)

      if board.empty?(pos)
        moves << pos
      else
        moves << pos if board[pos].color != color
        break
      end
    end
    moves
  end
end
