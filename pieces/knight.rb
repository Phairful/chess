
require_relative '../chess/piece' 


class Knight < Piece
  def initialize(color)
    super(color)
    @symbol = (color == 'white') ? "\u2658" : "\u265E" 
  end

  def valid_move?(start_x, start_y, end_x, end_y)
    dx = (start_x - end_x).abs
    dy = (start_y - end_y).abs

    (dx == 2 && dy == 1) || (dx == 1 && dy == 2)
  end
end
