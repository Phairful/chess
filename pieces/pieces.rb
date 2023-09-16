class Piece
  attr_reader :color, :symbol

  def initialize(color)
    @color = color 
    @symbol = ''   
  end

  def valid_move?(start_x, start_y, end_x, end_y)

    raise NotImplementedError, "Subclasses must implement valid_move?"
  end

  def to_s
    @symbol
  end
end