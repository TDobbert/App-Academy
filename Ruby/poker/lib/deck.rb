require_relative 'card'

class Deck
  attr_reader :deck_of_cards

  CARDS = {
    2 => '2',
    3 => '3',
    4 => '4',
    5 => '5',
    6 => '6',
    7 => '7',
    8 => '8',
    9 => '9',
    10 => '10',
    11 => 'J',
    12 => 'Q',
    13 => 'K',
    14 => 'A'
  }.freeze

  SUITS = [
    "\u2665", # heart
    "\u2666", # diamond
    "\u2663", # club
    "\u2660" # spade
  ].freeze

  def initialize
    @deck_of_cards = []

    populate_deck
    shuffle_deck!
  end

  def draw_card
    @deck_of_cards.shift
  end

  def shuffle_deck!
    @deck_of_cards.shuffle!
  end

  private

  def populate_deck
    CARDS.each do |card|
      SUITS.each do |suit|
        @deck_of_cards << Card.new(card, suit)
      end
    end
  end
end
