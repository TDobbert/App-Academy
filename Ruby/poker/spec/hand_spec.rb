require 'hand'
require 'rspec'

describe Hand do
  subject(:hand) { Hand.new }

  describe '#initialize' do
    it 'inititalizes hand of cards to an empty array' do
      expect(hand.current_hand).to be_empty
    end
  end

  describe '#four_of_a_kind?' do
    it 'returns true when a four of a kind' do
      hand.current_hand = [
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.four_of_a_kind?).to be true
    end

    it 'returns false when not a four of a kind' do
      hand.current_hand = [
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([4, '4'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.four_of_a_kind?).to be false
    end
  end

  describe '#full_house?' do
    it 'returns true when a hand is a full house' do
      hand.current_hand = [
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([4, '4'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.full_house?).to be true
    end

    it 'expects full_house to be false' do
      hand.current_hand = [
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.full_house?).to be false
    end
  end

  describe '#flush?' do
    it 'returns true when all the same suit' do
      hand.current_hand = [
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.flush?).to be true
    end

    it 'returns false when not all the same suit' do
      hand.current_hand = [
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2663"),
        Card.new([2, '2'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.flush?).to be false
    end
  end

  describe '#straight?' do
    it 'returns true when a straight' do
      hand.current_hand = [
        Card.new([14, 'A'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([3, '3'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.straight?).to be true
    end

    it 'returns false when not a straight' do
      hand.current_hand = [
        Card.new([10, '10'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([3, '3'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.straight?).to be false
    end
  end

  describe '#three_of_a_kind?' do
    it 'returns true when a three of a kind' do
      hand.current_hand = [
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.three_of_a_kind?).to be true
    end

    it 'returns false when not a three of a kind' do
      hand.current_hand = [
        Card.new([2, '2'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([12, 'Q'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.three_of_a_kind?).to be false
    end
  end

  describe '#two_pair?' do
    it 'returns true when two pairs' do
      hand.current_hand = [
        Card.new([2, '2'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.two_pair?).to be true
    end

    it 'returns false when not two pairs' do
      hand.current_hand = [
        Card.new([7, '7'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.two_pair?).to be false
    end
  end

  describe '#one_pair?' do
    it 'returns true when one pair' do
      hand.current_hand = [
        Card.new([2, '2'], "\u2665"),
        Card.new([10, '10'], "\u2665"),
        Card.new([2, '2'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.one_pair?).to be true
    end

    it 'returns false when not one pair' do
      hand.current_hand = [
        Card.new([2, '2'], "\u2665"),
        Card.new([10, '10'], "\u2665"),
        Card.new([9, '9'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.one_pair?).to be false
    end
  end

  describe '#high_card' do
    it 'returns high card' do
      hand.current_hand = [
        Card.new([2, '2'], "\u2665"),
        Card.new([10, '10'], "\u2665"),
        Card.new([9, '9'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.high_card).to eq(10)
    end
  end

  describe '#high_suit' do
    it 'returns high suit value' do
      hand.current_hand = [
        Card.new([2, '2'], "\u2665"),
        Card.new([10, '10'], "\u2660"),
        Card.new([9, '9'], "\u2665"),
        Card.new([5, '5'], "\u2665"),
        Card.new([4, '4'], "\u2665")
      ]
      expect(hand.high_suit).to eq(4)
    end
  end
end
