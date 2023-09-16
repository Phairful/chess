class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def make_move(game)
    loop do
      puts "#{name}, it's your turn (#{color.capitalize}):"

      start_position, end_position = get_move_input

      start_x, start_y = convert_position(start_position)
      end_x, end_y = convert_position(end_position)


      if valid_input?(start_position, end_position) &&
         game.board.in_bounds?(start_x, start_y) &&
         game.board.in_bounds?(end_x, end_y)

        if game.make_move(start_x, start_y, end_x, end_y)

        else
          puts "Invalid move. Try again."
        end
      else
        puts "Invalid input. Make sure to enter positions like 'a2' and 'a4'."
      end
    end
  end

  private

  def get_move_input
    print "Enter the starting position (e.g., 'a2'): "
    start_position = gets.chomp.downcase

    print "Enter the ending position (e.g., 'a4'): "
    end_position = gets.chomp.downcase

    [start_position, end_position]
  end

  def valid_input?(start_position, end_position)
    valid_format = /^[a-h][1-8]$/.match?(start_position) && /^[a-h][1-8]$/.match?(end_position)
    valid_format
  end

  def convert_position(position)
    x = position[0].ord - 'a'.ord
    y = 7 - position[1].to_i
    [x, y]
  end
end
