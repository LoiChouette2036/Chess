require_relative 'pieces/pawn.rb'
require_relative 'pieces/rook.rb'
require_relative 'pieces/bishop.rb'
require_relative 'pieces/knight.rb'
require_relative 'pieces/king.rb'
require_relative 'pieces/queen.rb'

class Board

    attr_reader :grid, :last_move

    def initialize
        @grid = Array.new(8){ Array.new(8,".") }
        setup_pieces # This ensures pieces are placed on the board at initialization
    end

    def setup_pieces
        set_pawns
    end

    def set_pawns
        # Place white pawns at row 1 (2nd row in human terms)
        @grid[1].each_index { |i| @grid[1][i] = Pawn.new('white', [1,i])}

        # Place black pawns at row 6 (7th row in human terms)
        @grid[6].each_index { |i| @grid[6][i] = Pawn.new('black',[6,i])}

        # Place white rook 
        @grid[0][0] = Rook.new('white',[0,0])
        @grid[0][7] = Rook.new('white',[0,7])
        #Place black rook
        @grid[7][0] = Rook.new('black',[7,0])
        @grid[7][7] = Rook.new('black',[7,7])

        # Place white bishop
        @grid[0][2]=Bishop.new('white',[0,2])
        @grid[0][5]=Bishop.new('white',[0,5])
        # Place black bishop
        @grid[7][2]=Bishop.new('black',[7,2])
        @grid[7][5]=Bishop.new('black',[7,5])

        #place white knights
        @grid[0][1]=Knight.new('white',[0,1])
        @grid[0][6]=Knight.new('white',[0,6])
        #place black knights
        @grid[7][1]=Knight.new('black',[7,1])
        @grid[7][6]=Knight.new('black',[7,6])

        #place kings
        @grid[0][4]=King.new('white',[0,4])
        @grid[7][4]=King.new('black',[7,4])
        #place queens
        @grid[0][3]=Queen.new('white',[0,3])
        @grid[7][3]=Queen.new('black',[7,3])
        
    end
    ###########################################
    def display
        @grid.each do |row|
            puts row.map { |cell| cell.is_a?(String) ? cell : cell.to_s }.join(" ")
        end
    end
    #########################################
    def move_piece(start_pos, end_pos)
        piece = @grid[start_pos[0]][start_pos[1]]
    
        if piece.is_a?(Piece)  # Check if the piece is actually a Piece object
            puts "Attempting to move piece from #{start_pos} to #{end_pos}"
            puts "Piece at start position: #{piece.class} at #{piece.position}" if piece
    
            if piece.move(end_pos, self)
                puts "After move: Checking grid at #{end_pos} -> #{grid[end_pos[0]][end_pos[1]].inspect}"
                @last_move = [start_pos, end_pos, piece]
                display
            else
                puts "Move failed."
                return false
            end
        else
            puts "No piece at start position."
            return false
        end
    end
    
    ##########################################################3
    
    def in_check?(color)
        # Find the position of the king of the specified color
        king_position = find_king(color)

        # Iterate over each row and each cell in the grid
        @grid.each_with_index do |row,row_index|
            row.each_with_index do |cell, col_index|
                # Skip empty cells and cells belonging to the current player
                next if cell == "." || cell.color == color
                # Check if the opponent's piece can move to the king's position
                return true if cell.valid_move?(king_position,self)
            end
        end
        # If no opponent's piece can move to the king's position, return false
        false
    end

    def find_king(color)
        # Iterate over each row and each cell in the grid
        @grid.each_with_index do |row, row_index|
            row.each_with_index do |cell, col_index|
                # Return the position [row_index, col_index] if a king of the specified color is found
                return [row_index, col_index] if cell.is_a?(King) && cell.color == color
            end
        end
        # Return nil if the king is not found (which ideally should never happen in a proper chess game)
        nil
    end

    def checkmate?(color)
        # First, check if the king is in check; if not, it's not checkmate
        return false unless in_check?(color)

        # Iterate over each cell in the grid to find the current player's pieces
        @grid.each_with_index do |row, row_index|
            row.each_with_index do |cell, col_index|
                # Skip empty cells and opponent's pieces; focus only on the current player's pieces
                next if cell == "." || cell.color != color
                # Iterate over all possible moves on the board (8x8 grid)
                (0..7).each do |new_row|
                    (0..7).each do |new_col|
                        # Define the current position and the target position for the move
                        original_pos = [row_index,col_index]
                        target_pos = [new_row,new_col]
                        # Check if the current piece can move to the target position
                        if cell.valid_move?(target_pos,self)
                            #temporarily perform the move
                            original_piece = @grid[new_row][new_col]
                            move_piece(original_pos,target_pos)
                            # Check if the king is still in check after the move
                            if !in_check?(color)
                                # If the king is no longer in check, it's not checkmate; undo the move
                                move_piece(target_pos,original_pos)
                                @grid[new_row][new_col] = original_piece
                                return false
                            end

                            # Undo the move to restore the board state
                            move_piece(target_pos, original_pos)
                            @grid[new_row][new_col] = original_piece
                        end
                    end
                end
            end
        end

        # If no valid moves can get the king out of check, it's checkmate
        true
    end
end

# Create a new board
board = Board.new

# Clear the board first to ensure a clean slate
board.grid.each_with_index do |row, row_index|
  row.each_with_index do |_, col_index|
    board.grid[row_index][col_index] = "."
  end
end

# Place a white pawn near the promotion row
board.grid[6][4] = Pawn.new('white', [6, 4])  # Place the pawn at row 6, column 4

# Display the board before the move
puts "Board before the pawn moves:"
board.display

# Move the white pawn to the promotion row
puts "\nMoving the pawn to the promotion row..."
board.move_piece([6, 4], [7, 4])  # Move the pawn to row 7, column 4 (promotion row)

# Directly check the grid after promotion
puts "\nAfter promotion, checking grid[7, 4]:"
puts board.grid[7][4].inspect

# Check the grid state again, immediately
puts "\nCheck again immediately:"
puts board.grid[7][4].inspect

# Display the board after the move and promotion
puts "\nBoard after the pawn is promoted:"
board.display

# Inspect the grid to verify that the pawn was promoted
puts "\nInspecting grid at [7, 4]:"
promoted_piece = board.grid[7][4]
puts "Piece at [7, 4]: #{promoted_piece.class}"
puts "Symbol at [7, 4]: #{promoted_piece.to_s}" if promoted_piece.is_a?(Piece)
