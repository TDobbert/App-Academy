class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.

    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  attr_accessor :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return nil if empty?

    @head.next
  end

  def last
    return nil if empty?

    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each { |node| return node.val if node.key == key }
  end

  def include?(key)
    each { |node| return true if node.key == key }
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    tail.prev.next = new_node
    new_node.prev = tail.prev
    new_node.next = tail
    tail.prev = new_node

    new_node
  end

  def update(key, val)
    each { |node| node.val = val if node.key == key }
    nil
  end

  def remove(key)
    each { |node| node.remove if node.key == key }
  end

  def each(&prc)
    node = head.next

    until node == tail
      prc.call(node)
      node = node.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
