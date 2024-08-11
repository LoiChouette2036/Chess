require_relative 'piece.rb'

class Pawn < Piece
    #attributes
    # @color [String] color of the pawn, either 'white' or 'black'
    # @position [Array] current position of the pawn on the chessboard as [row, column]
    attr_accessor :position
    attr_reader :color

    # Initializes a new Pawn with a color and position  
    def initialize(color, position)
        super(color,position)
        @symbol = color == 'white' ? "\u2659" : "\u265F" #unicode of representation of a pawn
    end

     # Attempts to move the pawn to a new position
    def move(target_position, board)
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

        # First, check if the new position is within the bounds of the chessboard
        if new_row.between?(0, 7) && new_col.between?(0, 7)
            # Calculate row movement based on pawn color
            direction = @color == 'white' ? 1 : -1

            target_cell = board[new_row][new_col]
            # Standard move: move forward to an empty space
            if new_col == current_col && new_row == current_row + direction
                return true if target_cell == "." # Check if the space is empty
        
            # Capturing move: move diagonally to capture an opponent's piece
            elsif (new_col==current_col+1 || new_col == current_col -1) && new_row == current_row + direction
                return true if target_cell != "." && target_cell.is_a?(Piece) && target_cell.color !=@color #check for opponent

            end
        end
        
        false #if none of the conditions are met, the move is invalid
    end


end