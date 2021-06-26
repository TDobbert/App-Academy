require 'colorize'
require_relative 'cursor'

class Display
  attr_reader :cursor, :board, :notifications

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
    @notifications = {}
  end

  def populate_grid
    @board.rows.map.with_index do |row, i|
      row.map.with_index do |piece, j|
        piece.to_s.colorize(grid_colors(i, j))
      end
    end
  end

  def grid_colors(i, j)
    if cursor.cursor_pos == [i, j]
      color = :red
    elsif (i + j).even?
      color = :blue
    else
      color = :light_black
    end
    { background: color }
  end

  def reset_board
    @notifications.delete(:error)
  end

  def uncheck
    @notifications.delete(:check)
  end

  def check
    @notifications[:check] = 'Check!'
  end

  def render
    system('clear')
    populate_grid.each { |row| puts row.join }

    @notifications.each { |_key, val| puts val }
  end
end
