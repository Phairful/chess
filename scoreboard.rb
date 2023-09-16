class Scoreboard
  attr_accessor :scores

  POINTS = {
    'pawn' => 1,
    'knight' => 3,
    'bishop' => 3,
    'rook' => 5,
    'queen' => 9
  }

  def initialize
    @scores = { 'white' => 0, 'black' => 0 }
  end

  def update_score(player_color, piece_type)
    points = POINTS[piece_type.downcase]
    if points
      @scores[player_color] += points
    else
      puts "Invalid piece type: #{piece_type}"
    end
  end

  def display_score
    puts "Scoreboard:"
    puts "White: #{@scores['white']} points"
    puts "Black: #{@scores['black']} points"
  end
end
