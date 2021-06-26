class Tile
  DELTAS = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [0, -1],
    [0,  1],
    [1, -1],
    [1,  0],
    [1,  1]
  ].freeze

  attr_accessor :pos

  def initialize(board, pos)
    @board = board
    @pos = pos
    @flagged = false
    @revealed = false
    @bomb = false
  end

  def bomb?
    @bomb
  end

  def place_bomb
    @bomb = true
  end

  def reveal
    return self if flagged?
    return self if revealed?

    @revealed = true
    neighbors.each(&:reveal) if !bomb? && neighbors_mine_count.zero?
    self
  end

  def revealed?
    @revealed
  end

  def flag
    @flagged = true
  end

  def flagged?
    @flagged
  end

  def neighbors
    row, col = pos
    neighbors = DELTAS.map do |delta|
      row_diff, col_diff = delta
      [row + row_diff, col + col_diff]
    end.select { |pos| @board.valid_board_pos(pos) }

    neighbors.map { |pos| @board[pos] }
  end

  def neighbors_mine_count
    neighbors.select(&:bomb?).count
  end

  def display_all
    if flagged?
      'F'
    elsif bomb?
      revealed? ? 'X' : 'B'
    else
      neighbors_mine_count.zero? ? '_' : neighbors_mine_count.to_s
    end
  end

  def renderer
    if flagged?
      'F'
    elsif revealed?
      neighbors_mine_count.zero? ? '_' : neighbors_mine_count.to_s
    elsif !revealed?
      '*'
    end
  end
end
