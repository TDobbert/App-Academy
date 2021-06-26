require 'rspec'
require 'card'

describe Card do
  describe '#initialize' do
    subject(:card) { Card.new([1, '1'], ["\u2665"]) }

    it 'sets a card value' do
      expect(card.card_value).to eq([1, '1'])
    end
    it 'sets a cards suit' do
      expect(card.card_suit).to eq(["\u2665"])
    end
  end
end
