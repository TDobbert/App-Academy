require_relative 'my_stack'

class MinMaxStack
  def initialize
    @store = MyStack.new
  end

  def peek
    @store.peek[:val]
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def max
    @store.peek[:max] unless empty?
  end

  def min
    @store.peek[:min] unless empty?
  end

  def pop
    @store.pop[:val] unless empty?
  end

  def push(ele)
    @store.push({
                  max: new_max(ele),
                  min: new_min(ele),
                  val: ele
                })
  end

  private

  def new_max(val)
    empty? ? val : [max, val].max
  end

  def new_min(val)
    empty? ? val : [min, val].min
  end
end
