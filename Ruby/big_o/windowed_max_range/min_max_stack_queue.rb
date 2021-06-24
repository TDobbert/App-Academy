require_relative 'min_max_stack'

class MinMaxStackQueue
  def initialize
    @push_stack = MinMaxStack.new
    @pop_stack = MinMaxStack.new
  end

  def size
    @push_stack.size + @pop_stack.size
  end

  def empty?
    @push_stack.empty? && @pop_stack.empty?
  end

  def enqueue(ele)
    @push_stack.push(ele)
  end

  def dequeue
    queueify if @pop_stack.empty?
    @pop_stack.pop
  end

  def max
    maxes = []
    maxes << @push_stack.max unless @push_stack.empty?
    maxes << @pop_stack.max unless @pop_stack.empty?
    maxes.max
  end

  def min
    mins = []
    mins << @push_stack.min unless @push_stack.empty?
    mins << @pop_stack.min unless @pop_stack.empty?
    mins.min
  end

  private

  def queueify
    @pop_stack.push(@push_stack.pop) until @push_stack.empty?
  end
end
