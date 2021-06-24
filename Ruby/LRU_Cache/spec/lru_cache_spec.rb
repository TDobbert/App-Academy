require 'rspec'
require 'lru_cache'

describe LRUCache do
  subject(:lru_cache) { LRUCache.new(4) }

  describe '#initialize' do
    it 'raises an error when no size is given in args' do
      expect { LRUCache.new }.to raise_error(ArgumentError)
      expect(lru_cache.size).to eq(4)
    end

    it 'expects cache to be an array and empty' do
      expect(lru_cache.cache).to be_empty
      expect(lru_cache.cache).to be_a_kind_of(Array)
    end
  end

  describe '#count' do
    it 'returns the count of items in the array' do 

    end
  end
end
