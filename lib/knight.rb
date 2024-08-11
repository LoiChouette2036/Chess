require_relative 'piece.rb'

class Knight < Piece
    attr_accessor :position
    attr_reader :color

    def initialize(color,position)
        super(color,position)
        @symbol = color == 'white' ? "\u2658" : "\u265E"
    end

    def move(target_position,board)
        if valid_move?(target_position,board)
            @position = target_position
            true
        else
            false
        end
    end

    def to_s
        @symbol
    end

    private

    def valid_move?(target_position, board)
        current_row, current_col = @position
        new_row, new_col = target_position
      
        # First, check if the new position is within the bounds of the chessboard
        if new_row.between?(0, 7) && new_col.between?(0, 7)
          
          # Check for a knight's L-shaped movement
          row_difference = new_row - current_row
          col_difference = new_col - current_col
      
          # Target cell on the board
          target_cell = board[new_row][new_col]
      
          # For a move to be in an L shape, the number of rows moved and columns moved must match the knight's movement pattern
          if (row_difference.abs == 2 && col_difference.abs == 1) || (row_difference.abs == 1 && col_difference.abs == 2)
            
            # Check if the target cell is empty or occupied by an opponent's piece
            return target_cell == "." || (target_cell != "." && target_cell.color != @color)
          end
        end
      
        # If not a valid move
        return false
    end
end      