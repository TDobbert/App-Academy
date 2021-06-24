class Stack
  def initialize
    # create ivar to store stack here!
    @array = []
  end

  def push(el)
    # adds an element to the stack
    array.push(el)
    el
  end

  def pop
    # removes one element from the stack
    array.pop
  end

  def peek
    # returns, but doesn't remove, the top element in the stack
    array.last
  end

  private

  attr_reader :array
end

class Queue
  def initialize
    @array = []
  end

  def enqueue(el)
    array.push(el)
    el
  end

  def dequeue
    array.shift
  end

  def peek
    array.first
  end

  private

  attr_reader :array
end

class Map
  def initialize
    @array = []
  end

  def set(key, value)
    pairs = array.index { |pair| pair[0] == key }
    if pairs
      array[pairs][1] = value
    else
      array.push([key, value])
    end
    value
  end

  def get(key)
    array.each { |pair| return pair[1] if pair[0] == key }
  end

  def delete(key)
    value = get(key)
    array.reject! { |pair| pair[0] == key }
    value
  end

  def show
    deep_dup(array)
  end

  private

  attr_reader :array

  def deep_dup(arr)
    arr.map { |el| el.is_a?(Array) ? deep_dup(el) : el }
  end
end
