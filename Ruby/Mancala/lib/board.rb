class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { [] }
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, i|
      4.times { cup << :stone unless [6, 13].include?(i) }
    end
  end

  def valid_move?(start_pos)
    raise 'Invalid starting cup' unless start_pos.between?(0, 12)
    raise 'Starting cup is empty' if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []

    until stones.empty?
      start_pos = (start_pos + 1) % @cups.length
      next if @name1 == current_player_name && start_pos == 13
      next if @name2 == current_player_name && start_pos == 6

      @cups[start_pos] << stones.pop
    end
    render
    next_turn(start_pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, 
    # or ending_cup_idx
    return :prompt if [6, 13].include?(ending_cup_idx)
    return :switch if @cups[ending_cup_idx].length == 1

    ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..6].all?(&:empty?) || @cups[7...12].all?(&:empty?)
  end

  def winner
    return :draw if @cups[6] == @cups[13]
    return @name1 if @cups[6].count > @cups[13].count
    return @name2 if @cups[6].count < @cups[13].count
  end
end
