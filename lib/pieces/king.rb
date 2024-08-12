require_relative 'piece.rb'

class King < Piece
    attr_accessor :position
    attr_reader :color

    def initialize(color, position)
        super(color,position)
        @symbol = color == 'white' ? "\u2654" : "\u265A"
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

    def valid_move?(target_position,board)
        current_row, current_col = @position
        new_row, new_col = target_position

        # Check if the target position is within one square in any direction
        if (new_row - current_row).abs <= 1 && (new_col-current_col) <= 1
            # Ensure the target is within the bounds of the board
            if new_row.between?(0, 7) && new_col.between?(0, 7)
                target_cell = board.grid[new_row][new_col]

                # Check if the target cell is empty or contains an opponent's piece
                return target_cell == "." || target_cell.color != @color
            end
        end

        return false
    end

end