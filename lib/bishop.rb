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
    
    def valid_move?(target_position,board)
        current_row, current_col = @position
        new_row, new_col = target_position

        # First, check if the new position is within the bounds of the chessboard
        if new_row.between?(0,7) && new_col.between?(0,7)

            #check for diagonal movement
            row_difference = new_row - current_row
            col_difference = new_col - current_col

            which_diagonal = [row_difference,col_difference]
            
            # For a move to be diagonal, the number of rows moved should be equal to the number of columns moved.
            if row_difference.abs == col_difference.abs
                #up-right
                if which_diagonal[0] < 0 && which_diagonal[1] > 0
                    #Iterating through the path to ensure all cells are clear
                    (current_col+1).upto(new_col) do |col|
                        row = current_row - (col - current_col)
                        return false unless board[row][col] == "."
                    end
                #up-left
                elsif which_diagonal[0] < 0 && which_diagonal[1] < 0
                    #Iterating through the path to ensure all cells are clear
                    (current_col - 1).downto(new_col) do |col|
                        row = current_row - (current_col - col)
                        return false unless board[row][col] == "."
                    end
                #down-right
                elsif which_diagonal[0] > 0 && which_diagonal[1] > 0
                    #Iterating through the path to ensure all cells are clear
                    (current_col+1).upto(new_col) do |col|
                        row = current_row + (col - current_col)
                        return false unless board[row][col] == "."
                    end
                #down-left
                elsif which_diagonal[0] > 0 && which_diagonal[1] < 0 
                    #Iterating through the path to ensure all cells are clear
                    (current_col - 1).downto(new_col) do |col|
                        row = current_row + (current_col - col)
                        return false unless board[row][col] == "."
                    end
                else
                    return false
                end
            else
                return false
            end
        end
        return false
    end


end
