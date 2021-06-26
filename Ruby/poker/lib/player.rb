require_relative 'hand'

class Player
  attr_reader :name, :bank, :hand, :folded, :holding, :raised, :called

  def initialize(name)
    @name = name
    @bank = 10
    @hand = Hand.new
    @folded = false
    @holding = false
    @raised = false
    @called = false
  end

  def place_bet(bet = nil)
    until bet && valid_amount?(bet)
      puts "How much would you like to bet #{@name}?"
      bet = gets.chomp.to_i
      puts 'Not enough money' unless valid_amount?(bet)
    end
    bet
  end

  def valid_amount?(bet)
    bet <= @bank
  end

  def discard_cards
    cards = []
    until !cards.empty? && valid_index_and_length?(cards)
      puts 'You can discard up to three cards (ex. 0 1 4)'
      cards = gets.chomp.split(' ').map(&:to_i)
      unless valid_index_and_length?(cards)
        puts 'Numbers must be between 0 and 4, and no more than 3 cards'
      end
    end
    cards
  end

  def valid_index_and_length?(cards)
    cards.all? { |card| card.between?(0, 4) } && cards.length < 4
  end

  def fold
    @folded = true
  end

  def unfold
    @folded = false
  end

  def hold
    @holding = true
  end

  def unhold
    @holding = false
  end

  def to_raise
    @raised = true
  end

  def unraise
    @raised = false
  end

  def call
    @called = true
  end

  def uncall
    @called = false
  end

  def subtract_bet(bet_amount)
    @bank -= bet_amount
  end

  def add_winnings(pot_amount)
    @bank += pot_amount
  end

  def lost?
    @bank <= 0
  end
end
