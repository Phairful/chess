class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def in_bounds?(x, y)
    x.between?(0, 7) && y.between?(0, 7)
  end

  def move_within_bounds?(start_x, start_y, end_x, end_y)
    in_bounds?(start_x, start_y) && in_bounds?(end_x, end_y)
  end

  def display
    puts "   a  b  c  d  e  f  g  h"
    puts " -------------------------"
    @grid.each_with_index do |row, i|
      print "#{8 - i} |"
      row.each do |piece|
        if piece.nil?
          print "  |"
        else
          print " #{piece.symbol} |"
        end
      end
      puts "\n -------------------------"
    end
  end
end