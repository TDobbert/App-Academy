module Stepable
  def moves
    moves = []
    move_diffs.each do |dx, dy|
      cur_x, cur_y = pos
      pos = [cur_x + dx, cur_y + dy]
      next unless board.valid_pos?(pos)

      moves << pos if board.empty?(pos) || board[pos].color != color
    end
    moves
  end

  def move_diffs
    raise NotImplementedError
  end
end
