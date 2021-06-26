require 'rspec'
require 'deck'

describe Deck do
  describe '#initialize' do
    subject(:deck) { Deck.new }

    it 'sets the deck to be an array' do
      expect(deck.deck_of_cards.class).to eq(Array)
    end

    it 'fills the deck with 52 cards' do
      expect(deck.deck_of_cards.length).to eq(52)
    end

    it 'has 13 of each suit' do
      expect(deck.deck_of_cards.find_all { |card| card.card_suit == "\u2665" }.count).to eq(13)
    end

    it 'has four of each card' do
      expect(deck.deck_of_cards.find_all { |card| card.card_value[1] == '3' }.count).to eq(4)
    end
  end
end
