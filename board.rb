class Board
    attr_reader :grid
  
    def initialize
      @grid = Array.new(8) { Array.new(8) }
      setup_pieces
    end
  
    def move_piece(start_pos, end_pos)
      piece = self[start_pos]
  
      if piece.nil?
        raise "No piece at starting position"
      elsif !piece.valid_moves(self).include?(end_pos)
        raise "Invalid move for the #{piece.class}"
      else
        self[end_pos] = piece
        self[start_pos] = nil
        piece.move_piece(end_pos)
      end
    end
  
    def [](pos)
      row, col = pos
      @grid[row][col]
    end
  
    def []=(pos, piece)
      row, col = pos
      @grid[row][col] = piece
    end
  
    private
  
    def setup_pieces
      place_pieces(:white, 0, 1)
      place_pieces(:black, 7, 6)
    end
  
    def place_pieces(color, back_row, front_row)
      @grid[back_row] = [
        Rook.new(color, [back_row, 0]),
        Knight.new(color, [back_row, 1]),
        Bishop.new(color, [back_row, 2]),
        Queen.new(color, [back_row, 3]),
        King.new(color, [back_row, 4]),
        Bishop.new(color, [back_row, 5]),
        Knight.new(color, [back_row, 6]),
        Rook.new(color, [back_row, 7])
      ]
      @grid[front_row].each_with_index do |_, i|
        @grid[front_row][i] = Pawn.new(color, [front_row, i])
      end
    end
  end
  