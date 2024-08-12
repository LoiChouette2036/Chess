require_relative 'piece.rb'

class Bishop < Piece
    attr_accessor :position
    attr_reader :color

    def initialize(color,position)
        super(color,position)
        @symbol = color == 'white' ? "\u2657" :  "\u265D"
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
      
          # Check for diagonal movement
          row_difference = new_row - current_row
          col_difference = new_col - current_col
      
          if row_difference.abs == col_difference.abs
            # Up-right
            if row_difference < 0 && col_difference > 0
              (current_col+1).upto(new_col - 1) do |col|
                row = current_row - (col - current_col)
                return false unless board.grid[row][col] == "."
              end
            # Up-left
            elsif row_difference < 0 && col_difference < 0
              (current_col - 1).downto(new_col + 1) do |col|
                row = current_row - (current_col - col)
                return false unless board.grid[row][col] == "."
              end
            # Down-right
            elsif row_difference > 0 && col_difference > 0
              (current_col+1).upto(new_col - 1) do |col|
                row = current_row + (col - current_col)
                return false unless board.grid[row][col] == "."
              end
            # Down-left
            elsif row_difference > 0 && col_difference < 0
              (current_col - 1).downto(new_col + 1) do |col|
                row = current_row + (current_col - col)
                return false unless board.grid[row][col] == "."
              end
            end
      
            # Check the target cell
            return board.grid[new_row][new_col] == "." || board.grid[new_row][new_col].color != @color
          end
        end
      
        return false
      end
      

end
