
require_relative '../chess/piece' 


class Rook < Piece
  def initialize(color)
    super(color)
    @symbol = (color == 'white') ? "\u2656" : "\u265C" 
  end

  def valid_move?(start_x, start_y, end_x, end_y)

    return true if start_x == end_x && start_y != end_y
    return true if start_y == end_y && start_x != end_x

    false
  end
end
