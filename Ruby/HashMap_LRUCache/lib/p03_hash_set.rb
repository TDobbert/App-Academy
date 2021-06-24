class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= num_buckets
    return nil if include?(key)

    self[key] << key
    @count += 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    @count -= 1 if self[key].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    prev_store = @store.flatten
    @store = Array.new(num_buckets * 2) { [] }
    @count = 0
    prev_store.each { |key| insert(key) }
  end
end
