require_relative '00_tree_node.rb'

class KnightPathFinder
  attr_reader :start_node

  MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [1, -2],
    [1,  2],
    [2, -1],
    [2,  1]
  ].freeze

  def self.valid_moves(pos)
    valid_moves = []

    x_pos, y_pos = pos
    MOVES.each do |(move_x, move_y)|
      new_pos = [x_pos + move_x, y_pos + move_y]

      valid_moves << new_pos if new_pos.all? { |coord| coord.between?(0, 7) }
    end
    valid_moves
  end

  def initialize(start_node)
    @start_node = start_node
    @considered_positions = [start_node]

    build_move_tree
  end

  def find_path(end_pos)
    end_node = root_node.dfs(end_pos)
    trace_path_back(end_node).map(&:value)
  end

  private

  attr_accessor :root_node, :considered_positions

  def build_move_tree
    self.root_node = PolyTreeNode.new(start_node)

    queue = [root_node]
    until queue.empty?
      current_node = queue.shift

      current_pos = current_node.value
      new_move_positions(current_pos).each do |next_pos|
        next_node = PolyTreeNode.new(next_pos)
        current_node.add_child(next_node)
        queue << next_node
      end
    end
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    new_move = valid_moves.reject { |move| considered_positions.include?(move) }
    new_move.each { |move| considered_positions << move }
    new_move
  end

  def trace_path_back(end_node)
    path = []

    current_node = end_node
    until current_node.nil?
      path << current_node
      current_node = current_node.parent
    end
    path.reverse
  end
end

if $PROGRAM_NAME == __FILE__
  kpf = KnightPathFinder.new([0, 0])
  p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
  p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
end
