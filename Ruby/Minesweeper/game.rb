require_relative 'board'
require 'yaml'
require 'byebug'

class Minesweeper
  def self.start_game
    input = nil
    until input && valid_choice?(input)
      puts 'Would you like to load a previos game? (y/n)'

      begin
        input = gets.chomp
      rescue
        puts 'Must enter y or n'
        puts ''
      end
    end
    make_choice(input)
  end

  def self.make_choice(input)
    case input
    when 'y'
      load
    when 'n'
      game = Minesweeper.new
      game.play
    end
  end

  def self.valid_choice?(input)
    valid_input = 'yn'
    valid_input.include?(input)
  end

  def self.load
    puts 'Enter the filename.'
    filename = gets.chomp
    file_contents = File.read(filename)
    saved_game = YAML.load(file_contents)
    saved_game.play
  end

  attr_reader :board

  def initialize
    @board = Board.new
  end

  def get_pos
    pos = nil
    until pos && valid_pos?(pos)
      get_pos_prompt

      begin
        pos = parse_pos(gets.chomp)
      rescue
        puts 'Invalid position entered. Try again.'
        puts ''

        pos = nil
      end
    end
    pos
  end

  def get_parameters
    parameters = nil
    until parameters && valid_parameters?(parameters)
      get_parameters_prompt

      begin
        parameters = gets.chomp
      rescue
        puts 'Invalid command'
        puts ''

        parameters = nil
      end
    end
    parameters
  end

  def get_pos_prompt
    puts "Enter a position on the board (e.g., '3,4')"
    print '> '
  end

  def get_parameters_prompt
    puts 'Enter a command'
    puts '"r" to reveal a tile, "f" to flag a tile,'
    puts '"s" to save the game'
    print '> '
  end

  def parse_pos(string)
    string.split(',').map { |char| Integer(char) }
  end

  def valid_pos?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |num| num.between?(0, board.size - 1) }
  end

  def valid_parameters?(parameters)
    valid = 'rfs'
    valid.include?(parameters)
  end

  def play
    until board.won? || board.lost?
      puts board.render
      pos = get_pos
      parameters = get_parameters
      make_move(pos, parameters)
    end

    board.game_over?
  end

  def make_move(pos, parameters)
    tile = @board[pos]

    case parameters
    when 'r'
      tile.reveal
    when 'f'
      tile.flag
    when 's'
      save_game
    end
  end

  def save_game
    puts 'Enter a filename to save: (ex. ms1.txt)'
    filename = gets.chomp

    File.write(filename, YAML.dump(self))
  end
end

Minesweeper.start_game if __FILE__ == $PROGRAM_NAME
