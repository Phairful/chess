
require_relative '../chess/piece'


class Queen < Piece
  def initialize(color)
    super(color)
    @symbol = (color == 'white') ? "\u2655" : "\u265B" 
  end

  def valid_move?(start_x, start_y, end_x, end_y)

    return true if start_x == end_x || start_y == end_y || (start_x - end_x).abs == (start_y - end_y).abs

    false
  end
end
