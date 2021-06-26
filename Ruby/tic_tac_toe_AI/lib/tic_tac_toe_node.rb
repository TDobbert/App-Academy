require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos 

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    winner = @board.winner

    return board.won? && winner != evaluator if @board.over?

    if evaluator == @next_mover_mark
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    winner = @board.winner

    return winner == evaluator if @board.over?

    if evaluator == @next_mover_mark
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  def switch_mark(mark)
    mark == :x ? :o : :x
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []

    @board.rows.each_with_index do |row, idx1|
      row.each_with_index do |_col, idx2|
        pos = [idx1, idx2]
        dup_board = board.dup

        next unless dup_board.empty?(pos)

        dup_board[pos] = @next_mover_mark
        node = TicTacToeNode.new(dup_board, switch_mark(@next_mover_mark), pos)
        children << node
      end
    end
    children
  end
end
