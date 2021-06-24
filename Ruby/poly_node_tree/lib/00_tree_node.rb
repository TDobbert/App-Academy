class PolyTreeNode

  attr_accessor :value
  attr_reader :parent

  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def children
    @children
  end

  def parent=(parent)
    return if @parent == parent

    @parent.children.delete(self) unless self.parent.nil?
    @parent = parent
    @parent.children << self unless self.parent.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "not a child" unless @children.include?(child_node)

    child_node.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value

    @children.each do |child|
      search_result = child.dfs(target_value)
      return search_result unless search_result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      next_el = queue.shift
      return next_el if next_el.value == target_value

      next_el.children.each { |child| queue << child }
    end
    nil
  end
end
