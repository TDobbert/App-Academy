require_relative 'pieces'
require 'byebug'

class Board
  attr_reader :rows, :sentinel

  def initialize(place_pieces = true)
    @sentinel = NullPiece.instance
    @rows = Array.new(8) { Array.new(8, sentinel) }

    fill_board(place_pieces)
  end

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @rows[row][col] = piece
  end

  def move_piece(color, start_pos, end_pos)
    raise 'Start posision is empty' if start_pos.empty?

    piece = self[start_pos]
    raise 'Cannot move opponents piece' unless piece.color == color
    raise 'Invalid move' unless piece.moves.include?(end_pos)
    raise 'Cannot move into check' unless piece.valid_moves.include?(end_pos)

    move_piece!(start_pos, end_pos)
  end

  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def checkmate?(color)
    return false unless in_check?(color)

    selected = pieces.select { |p| p.color == color }
    selected.all? { |piece| piece.valid_moves.empty? }
    true
  end

  def in_check?(color)
    king_pos = find_king(color).pos
    pieces.any? { |p| p.color != color && p.moves.include?(king_pos) }
  end

  def find_king(color)
    pieces.find { |piece| piece.color == color && piece.is_a?(King) }
  end

  def pieces
    @rows.flatten.reject(&:empty?)
  end

  def empty?(pos)
    self[pos].empty?
  end

  def dup
    duped_board = Board.new(false)
    pieces.each { |piece| piece.class.new(piece.color, duped_board, piece.pos) }
    duped_board
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    self[end_pos] = piece
    self[start_pos] = sentinel
    piece.pos = end_pos

    nil
  end

  def fill_back_row(color)
    back_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ]

    i = color == :white ? 7 : 0
    back_pieces.each_with_index do |piece_class, j|
      piece_class.new(color, self, [i, j])
    end
  end

  def fill_pawns_row(color)
    i = color == :white ? 6 : 1
    8.times { |j| Pawn.new(color, self, [i, j]) }
  end

  def fill_board(place_pieces)
    return unless place_pieces

    fill_back_row(:black)
    fill_back_row(:white)
    fill_pawns_row(:black)
    fill_pawns_row(:white)
  end
end
