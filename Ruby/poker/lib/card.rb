class Card
  attr_reader :card_value, :card_suit

  def initialize(card_value, card_suit)
    @card_value = card_value
    @card_suit = card_suit
  end
end
