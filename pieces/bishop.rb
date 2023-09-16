
require_relative '../chess/piece' 


class Bishop < Piece
  def initialize(color)
    super(color)
    @symbol = (color == 'white') ? "\u2657" : "\u265D" 
  end

  def valid_move?(start_x, start_y, end_x, end_y)
    dx = (start_x - end_x).abs
    dy = (start_y - end_y).abs

    dx == dy
  end
end
