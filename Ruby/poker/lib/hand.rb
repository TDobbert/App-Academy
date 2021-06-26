require_relative 'deck'

class Hand
  # starts after highest card Ace 14
  RANKING = {
    one_pair: 15,
    two_pair: 16,
    three_of_a_kind: 17,
    straight: 18,
    flush: 19,
    full_house: 20,
    four_of_a_kind: 21,
    straight_flush: 22
  }.freeze

  SUITS = {
    "\u2663" => 1, # club
    "\u2666" => 2, # diamond
    "\u2665" => 3, # heart
    "\u2660" => 4 # spade
  }.freeze

  attr_accessor :current_hand, :hand_rank

  def initialize
    @current_hand = []
    @hand_rank = 0
  end

  def winning_hand_rankings_one
    return RANKING[:straight_flush] if straight_flush?
    return RANKING[:four_of_a_kind] if four_of_a_kind?
    return RANKING[:full_house] if full_house?
    return RANKING[:flush] if flush?

    nil
  end

  def winning_hand_rankings_two
    return RANKING[:straight] if straight?
    return RANKING[:three_of_a_kind] if three_of_a_kind?
    return RANKING[:two_pair] if two_pair?
    return RANKING[:one_pair] if one_pair?

    high_card
  end

  def determine_rank
    if !winning_hand_rankings_one.nil?
      winning_hand_rankings_one
    else
      winning_hand_rankings_two
    end
  end

  def high_pair
    count_like_cards.key(count_like_cards.values.max)
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    count_like_cards.any? { |card| card[1] == 4 }
  end

  def full_house?
    three_of_a_kind? && one_pair?
  end

  def flush?
    current_hand.all? { |card| card.card_suit == current_hand[0].card_suit }
  end

  def straight?
    ace_case = [2, 3, 4, 5, 14]
    hand = current_hand.map { |card| card.card_value.first }.sort
    return true if hand == ace_case

    hand[0...-1].each_with_index do |card, i|
      return false unless card + 1 == hand[i + 1]
    end
    true
  end

  def three_of_a_kind?
    count_like_cards.any? { |card| card[1] == 3 }
  end

  def two_pair?
    count = count_like_cards.count { |_card, value| value == 2 }
    return true if count == 2

    false
  end

  def one_pair?
    count_like_cards.any? { |card| card[1] == 2 }
  end

  def high_card
    current_hand.map(&:card_value).max.first
  end

  def high_suit
    current_hand.each do |card|
      return SUITS[card.card_suit] if card.card_value.first == high_card
    end
  end

  def count_like_cards
    cards = Hash.new(0)
    current_hand.each do |card|
      cards[card.card_value] += 1
    end
    cards
  end
end
