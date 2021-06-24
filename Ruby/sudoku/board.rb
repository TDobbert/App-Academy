require_relative 'tile'

class Board
  attr_reader :grid

  def self.empty_grid(size = 9)
    @grid = Array.new(size) { Array.new(size) }
    grid
  end

  def self.from_file(filename)
    rows = File.readlines(filename).map(&:chomp)
    tiles = rows.map do |row|
      nums = row.split('').map(&:to_i)
      nums.map { |num| Tile.new(num) }
    end

    self.new(tiles)
  end

  def initialize(grid)
    @grid = grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    tile = @grid[row][col]
    tile.value = value
  end

  def size
    @grid.size
  end

  def render
    puts 'Sudoku'
    puts "  #{(0...size).to_a.join(' ')}"
    @grid.each_with_index do |row, i|
      puts "#{i} #{row.join(' ')}"
    end
  end

  def solved?
    row_solved? && col_solved? && square_solved?
  end

  def row_solved?
    @grid.all? { |row| row.length == row.uniq.length }
  end

  def col_solved?
    @grid.transpose.all? { |col| col.length == col.uniq.length }
  end

  def square_solved?
    squares.all? do |tiles|
      nums = tiles.map(&:value)
      nums.sort == (1..9).to_a
    end
  end

  def square(index)
    tiles = []
    x = (index / 3) * 3
    y = (index % 3) * 3

    (x...x + 3).each do |i|
      (y...y + 3).each do |j|
        tiles << self[[i, j]]
      end
    end

    tiles
  end

  def squares
    (0...@grid.length).to_a.map { |i| square(i) }
  end

  def dup
    duped_grid = grid.map do |row|
      row.map { |tile| Tile.new(tile.value) }
    end

  Board.new(duped_grid)
  end
end
