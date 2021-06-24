require_relative 'my_stack'

class StackQueue
  def initialize
    @push_stack = MyStack.new
    @pop_stack = MyStack.new
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

  private

  def queueify
    # turn stack into a queue
    @pop_stack.push(@push_stack.pop) until @push_stack.empty?
  end
end
