require 'colorize'

class Tile
  attr_reader :value

  def initialize(value)
    @value = value
    @given = !value.zero?
  end

  def given?
    @given
  end

  def color
    given? ? :blue : :red
  end

  def to_s
    @value.zero? ? ' ' : value.to_s.colorize(color)
  end

  def value=(new_value)
    if given?
      puts 'Given values can not be altered.'
    else
      @value = new_value
    end
  end
end
