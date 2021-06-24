class MazeSolver
  attr_reader :maze, :current_pos, :visited_pos, :path

  def initialize(maze = 'maze1.txt')
    @maze = load_map(maze)
  end

  def load_map(filename)
    new_maze = File.readlines(filename)
    new_maze.map! { |line| line.strip.chars }
  end

  def [](pos)
    row, col = pos
    @maze[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @maze[row][col] = val
  end

  def run
    source = find_char('S')
    target = find_char('E')
    @current_pos = [source]
    @visited_pos = { source => nil }

    explore until @current_pos.empty? || visited_pos.key?(target)

    @path = build_path(target)
    @maze.each { |row| puts row.join('') }
  end

  def build_path(target)
    return [target] if @visited_pos[target].nil?

    prev_pos = @visited_pos[target]
    self[target] = 'X' unless self[target] == 'E'
    current_path = [target]
    current_path.concat(build_path(prev_pos))
  end

  def explore
    new_current_pos = []

    @current_pos.each do |pos|
      adjacent_pos(pos).each do |adj_pos|
        unless @visited_pos.include?(adj_pos)
          new_current_pos << adj_pos
          @visited_pos[adj_pos] = pos
        end
      end
    end
    @current_pos = new_current_pos
  end

  def adjacent_pos(pos)
    row, col = pos

    adj = [[row + 1, col], [row - 1, col], [row, col + 1], [row, col - 1]]
    adj.reject { |p| self[p] == '*' }
  end

  def find_char(str)
    row = @maze.index { |row_idx| row_idx.include?(str) }
    col = @maze[row].index(str)
    [row, col]
  end
end

MazeSolver.new.run if __FILE__ == $PROGRAM_NAME
