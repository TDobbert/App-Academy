require 'rspec'
require 'player'

describe Player do
  subject(:player) { Player.new('Tom') }

  describe '#initialize' do
    it 'raises an error when no name is given in args' do
      expect { Player.new }.to raise_error(ArgumentError)
      expect(player.name).to eq('Tom')
    end

    it 'defaults the player bank to 10' do
      expect(player.bank).to eq(10)
    end

    it 'creates a new Hand' do
      expect(player.hand.class).to eq(Hand.new.class)
    end

    it 'sets folded to false' do
      expect(player.folded).to eq(false)
    end

    it 'sets holding to false' do
      expect(player.holding).to eq(false)
    end

    it 'sets raised to false' do
      expect(player.raised).to eq(false)
    end

    it 'sets called to false' do
      expect(player.called).to eq(false)
    end
  end
end
