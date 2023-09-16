require_relative 'board' 

class Game
  attr_accessor :board, :white_pieces, :black_pieces, :current_player, :check, :checkmate, :captured_pieces

  def initialize
    @board = Board.new
    @white_pieces = []
    @black_pieces = []
    @current_player = 'white'
    @check = false
    @checkmate = false
    @captured_pieces = { 'white' => [], 'black' => [] }
    setup_initial_board
  end

  def setup_initial_board
    place_pieces('white')
    place_pieces('black')
  end

  def place_pieces(color)
    back_rank = (color == 'white') ? 0 : 7
    pawn_rank = (color == 'white') ? 1 : 6

    (0..7).each do |x|
      @board.grid[pawn_rank][x] = Pawn.new(color)
      instance_variable_get("@#{color}_pieces") << @board.grid[pawn_rank][x]
    end

    piece_classes = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    piece_classes.each_with_index do |piece_class, x|
      @board.grid[back_rank][x] = piece_class.new(color)
      instance_variable_get("@#{color}_pieces") << @board.grid[back_rank][x]
    end
  end

  def switch_player
    @current_player = (@current_player == 'white') ? 'black' : 'white'
  end

  def make_move(start_x, start_y, end_x, end_y)
    piece = @board.grid[start_y][start_x]


    unless valid_move?(piece, start_x, start_y, end_x, end_y)
      return false
    end

    move_piece(start_x, start_y, end_x, end_y, piece)
    check_for_check_and_checkmate
    switch_player

    true
  end

  def valid_move?(piece, start_x, start_y, end_x, end_y)
    return false if piece.nil?
    return false if piece.color != @current_player
    return false unless piece.valid_move?(start_x, start_y, end_x, end_y)


    destination_piece = @board.grid[end_y][end_x]
    return false if destination_piece && destination_piece.color == piece.color

    true
  end

  def move_piece(start_x, start_y, end_x, end_y, piece)

    @captured_pieces[@current_player] << @board.grid[end_y][end_x] unless @board.grid[end_y][end_x].nil?


    @board.grid[end_y][end_x] = piece
    @board.grid[start_y][start_x] = nil
  end

  def check_for_check
    king_x, king_y = find_king_position(@current_player)
  
    opponent = (@current_player == 'white') ? 'black' : 'white'
    @board.grid.each_with_index do |row, y|
      row.each_with_index do |piece, x|
        next if piece.nil? || piece.color != opponent
        return true if piece.valid_move?(x, y, king_x, king_y)
      end
    end
  
    false
  end
  
  def find_king_position(color)
    @board.grid.each_with_index do |row, y|
      row.each_with_index do |piece, x|
        next if piece.nil? || piece.color != color
        return [x, y] if piece.is_a?(King)
      end
    end
    nil
  end

  def check_for_checkmate
    return false unless check_for_check 
  
    @board.grid.each_with_index do |row, start_y|
      row.each_with_index do |piece, start_x|
        next if piece.nil? || piece.color != @current_player
        (0..7).each do |end_y|
          (0..7).each do |end_x|
            next unless piece.valid_move?(start_x, start_y, end_x, end_y)
            temp_piece = @board.grid[end_y][end_x]
            @board.grid[end_y][end_x] = piece
            @board.grid[start_y][start_x] = nil
            unless check_for_check
              @board.grid[end_y][end_x] = temp_piece
              @board.grid[start_y][start_x] = piece
              return false
            end
            @board.grid[end_y][end_x] = temp_piece
            @board.grid[start_y][start_x] = piece
          end
        end
      end
    end
  end
  

  def game_over?
    return 'Checkmate' if check_for_checkmate
    return 'Stalemate' if stalemate?
    return 'Draw' if draw? 
    false
  end
