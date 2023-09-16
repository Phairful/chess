
require_relative '../chess/piece' 


class King < Piece
  def initialize(color)
    super(color)
    @symbol = (color == 'white') ? "\u2654" : "\u265A" 
  end

  def valid_move?(start_x, start_y, end_x, end_y)

    dx = (start_x - end_x).abs
    dy = (start_y - end_y).abs

    dx <= 1 && dy <= 1
  end
end
