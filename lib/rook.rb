require_relative 'piece.rb'

class Rook < Piece

    attr_accessor :position
    attr_reader :color

    def initialize(color,position)
        super(color,position)
        @symbol = color == 'white' ? "\u2656" : "\u265C"
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
    
        # Check if the move is in the same row or the same column
        if current_row == new_row || current_col == new_col
            # First, check if the new position is within the bounds of the chessboard
            if new_row.between?(0, 7) && new_col.between?(0, 7)
                target_cell = board[new_row][new_col]
    
                # Horizontal move
                if current_row == new_row
                    # Determine the correct range based on the direction of the move
                    range = current_col < new_col ? (current_col + 1..new_col - 1) : (new_col + 1..current_col - 1)
                    range.each do |col|
                        return false unless board[current_row][col] == "."
                    end
                end
    
                # Vertical move
                if current_col == new_col
                    range = current_row < new_row ? (current_row + 1..new_row - 1) : (new_row + 1..current_row - 1)
                    range.each do |row|
                        return false unless board[row][current_col] == "."
                    end
                end
    
                # Check the target cell
                return target_cell == "." || target_cell.color != @color
            end
        end
    
        return false
    end
    

end