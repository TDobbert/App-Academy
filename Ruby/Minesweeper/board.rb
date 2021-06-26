require_relative 'tile'
require 'byebug'

class Board
  attr_reader :grid

  def initialize
    @total_bombs = 10
    populate_grid
  end

  def populate_grid(size = 9)
    @grid = Array.new(size) do |row|
      Array.new(size) { |col| Tile.new(self, [row, col]) }
    end

    place_bombs
  end

  def place_bombs
    num_bombs = 0
    while num_bombs < @total_bombs
      rand_row = rand(0...size)
      rand_col = rand(0...size)
      pos = [rand_row, rand_col]
      tile = self[pos]
      next if tile.bomb?

      tile.place_bomb
      num_bombs += 1
    end
    
    nil
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def size
    @grid.length
  end

  def render(reveal = false)
    @grid.map do |row|
      row.map do |tile|
        reveal ? tile.display_all : tile.renderer
      end.join(' ')
    end.join("\n")
  end

  def reveal
    render(true)
  end

  def won?
    @grid.flatten.all? { |tile| tile.bomb? != tile.revealed? }
  end

  def lost?
    @grid.flatten.any? { |tile| tile.bomb? && tile.revealed? }
  end

  def game_over?
    if won?
      puts 'You Win!'
    elsif lost?
      puts 'Bomb Hit! You Lose!'
      puts reveal
    end
  end

  def valid_board_pos(pos)
    pos.all? { |num| num.between?(0, size - 1) }
  end
end
