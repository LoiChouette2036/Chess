require_relative 'piece.rb'

class King < Piece
    attr_accessor :position, :has_moved
    attr_reader :color

    def initialize(color, position)
        super(color,position)
        @symbol = color == 'white' ? "\u2654" : "\u265A"
        @has_moved = false
    end

    def move(target_position,board)
        if valid_move?(target_position,board)
            if can_castle?(target_position,board)
                perform_castling(target_position,board)
            end
            
            @position = target_position
            @has_moved = true
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
        elsif !@has_moved && (current_row == new_row) && (new_col - current_col).abs == 2
            return can_castle?(target_position,board)
        end


        return false
    end

    def can_castle?(target_position,board)
        row,col = @position
        rook_col = target_position[1] > col ? 7 : 0
        rook = board.grid[row][rook_col]

        return false unless rook.is_a?(Rook) && !rook.has_moved

        # Ensure path between king and rook is clear
        range = col < rook_col ? (col+1...rook_col) : (rook_col +1...col)
        range.each { |c| return false unless board.grid[row][c] == "." }

        true
    end

    def perform_castling(target_position, board)
        row, col = @position
        rook_col = target_position[1] > col ? 7 : 0
        rook_new_col = target_position[1] > col ? 5 : 3
    
        # Move the rook to its new position
        rook = board.grid[row][rook_col]
        board.grid[row][rook_new_col] = rook
        board.grid[row][rook_col] = "."
        rook.position = [row, rook_new_col]
    end


end