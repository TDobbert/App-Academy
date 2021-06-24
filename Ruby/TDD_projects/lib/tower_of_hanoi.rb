require 'byebug'

class Game
  attr_reader :towers, :disks

  def initialize
    @disks = [3, 2, 1]
    @towers = [[3, 2, 1], [], []]
  end

  def play
    display

    until won?
      input = get_input
      if valid_move?(*input)
        move(*input)
        display
      else
        display
        puts 'Invalid move, try again.'
      end
    end

    display
    puts 'YOU WIN!'
  end

  def won?
    towers[0].empty? && towers.any? { |tower| tower == disks }
  end

  def render
    towers.each do |tower|
      puts tower
      puts '----'
    end
  end

  def display
    system('clear')
    render
  end

  def move(from_tower, to_tower)
    raise 'cant move from an empty tower' if towers[from_tower].empty?
    unless valid_move?(from_tower, to_tower)
      raise 'cant move onto a smaller disk'
    end

    towers[to_tower] << towers[from_tower].pop
  end

  def valid_move?(from_tower, to_tower)
    return false unless [from_tower, to_tower].all? { |i| i.between?(0, 2) }

    !@towers[from_tower].empty? && (
      @towers[to_tower].empty? ||
      @towers[to_tower].last > towers[from_tower].last
    )
  end

  def get_input
    puts 'choose a tower to move a disk from'
    from_tower = gets.chomp.to_i

    puts 'choose a tower to move a disk to'
    to_tower = gets.chomp.to_i

    [from_tower, to_tower]
  end
end

if $PROGRAM_NAME == __FILE__
  TowersOfHanoiGame.new.play
end
