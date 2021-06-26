require 'rspec'
require 'game'

describe PokerGame do
  let(:player1) { Player.new('Tom') }
  let(:player2) { Player.new('Jim') }
  subject(:game) { PokerGame.new([player1, player2]) }

  describe '#initialize' do
    it 'raises an error if there are no players' do
      expect { PokerGame.new }.to raise_error(ArgumentError)
    end

    it 'initializes a new deck' do
      expect(game.deck.class).to eq(Deck.new.class)
    end

    it 'starts the pot at 0' do 
      expect(game.pot).to eq(0)
    end

    it 'starts the current bet at 0' do
      expect(game.current_bet).to eq(0)
    end
  end
end
