require_relative 'piece'

class Pawn < Piece
  def symbol
    '♟'.colorize(color)
  end

  def moves
    forward_steps + side_attacks
  end

  private

  def at_start_row?
    pos[0] == (color == :white) ? 6 : 1
  end

  # returns 1 or -1
  def forward_dir
    color == :white ? -1 : 1
  end

  def forward_steps
    x, y = pos
    steps = [[x + forward_dir, y]].select { |step| valid_steps?(step) }
    second_step = [x + (2 * forward_dir), y]
    steps << second_step if at_start_row? && board.empty?(second_step)
    steps
  end

  def valid_steps?(step)
    board.valid_pos?(step) && board.empty?(step)
  end

  def side_attacks
    x, y = pos
    side_steps = [[x + forward_dir, y - 1], [x + forward_dir, y + 1]]

    side_steps.select do |new_pos|
      board.valid_pos?(new_pos) && board[new_pos].color != color
    end
  end
end
