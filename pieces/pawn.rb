
require_relative '../chess/piece'

class Pawn < Piece
  def initialize(color)
    super(color)
    @symbol = (color == 'white') ? "\u2659" : "\u265F" 
  end

  def valid_move?(start_x, start_y, end_x, end_y)
    direction = (color == 'white') ? 1 : -1


    return true if start_y == end_y && (end_x - start_x) == direction


    return true if start_y == end_y && (end_x - start_x) == 2 * direction && at_starting_position?(start_x, start_y)


    return true if (end_y - start_y).abs == 1 && (end_x - start_x) == direction

    false
  end

  private

  def at_starting_position?(x, y)
    (color == 'white' && y == 1) || (color == 'black' && y == 6)
  end
end
