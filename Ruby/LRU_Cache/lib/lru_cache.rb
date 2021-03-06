class LRUCache
  attr_reader :size, :cache

  def initialize(size)
    @cache = []
    @size = size
  end

  def count
    # returns number of elements currently in cache
    @cache.count
  end

  def add(ele)
    # adds element to cache according to LRU principle
    if @cache.include?(ele)
      @cache.delete(ele)
    elsif count >= @size
      @cache.shift
    end
    @cache.push(ele)
  end

  def show
    # shows the items in the cache, with the LRU item first
    p @cache
  end
end

johnny_cache = LRUCache.new(4)

johnny_cache.add("I walk the line")
johnny_cache.add(5)

johnny_cache.count # => returns 2

johnny_cache.add([1,2,3])
johnny_cache.add(5)
johnny_cache.add(-5)
johnny_cache.add({a: 1, b: 2, c: 3})
johnny_cache.add([1,2,3,4])
johnny_cache.add("I walk the line")
johnny_cache.add(:ring_of_fire)
johnny_cache.add("I walk the line")
johnny_cache.add({a: 1, b: 2, c: 3})

johnny_cache.show # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]