class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return @store[i] if i >= 0

    return unless i.negative?

    return nil if i < -length

    self[length + i]
  end

  def []=(i, val)
    if i == @count
      push(val)
    elsif i > @count
      (i - @count).times { push(nil) }
      push(val)
    elsif i.negative?
      @store[count + i] = val
    elsif i < @count
      @store[i] = val
    end
  end

  def capacity
    @store.length
  end

  def include?(val)
    any? { |ele| ele == val }
  end

  def push(val)
    resize! if @count >= capacity
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == capacity
    @count += 1
    @count.downto(1).each { |i| self[i] = @store[i - 1] }
    @store[0] = val
  end

  def pop
    return nil if @count.zero?

    last_item = last
    self[@count - 1] = nil
    @count -= 1
    last_item
  end

  def shift
    return nil if @count.zero?

    first_item = first
    (1...@count).each { |i| @store[i - 1] = @store[i] }
    self[@count - 1] = nil
    @count -= 1
    first_item
  end

  def first
    self[0]
  end

  def last
    self[-1]
  end

  def each
    @count.times { |i| yield(@store[i]) }
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless @count == other.length

    each_with_index { |ele, idx| return false unless ele == other[idx] }
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)
    each_with_index { |ele, idx| new_store[idx] = ele }
    @store = new_store
  end
end
