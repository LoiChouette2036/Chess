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
    #def move(target_position, board)
    #    if valid_move?(target_position, board)
    #        @position = target_position
   # 
    #        if promotion_row?
    #            promoted_piece = promote_pawn
    #            puts "Before updating grid: #{board.grid[target_position[0]][target_position[1]].inspect}"
    #            board.grid[target_position[0]][target_position[1]] = promoted_piece
    #            puts "Immediately after promotion, grid[#{target_position[0]}, #{target_position[1]}]: #{board.grid[target_position[0]][target_position[1]].inspect}"
    #        else
    #            board.grid[target_position[0]][target_position[1]] = self
    #        end
    
    #       puts "After promotion and assignment, grid[#{target_position[0]}, #{target_position[1]}]: #{board.grid[target_position[0]][target_position[1]].inspect}"
    
    #        true
    #    else
    #        false
    #    end
    #end 
    def move(target_position, board)
        if valid_move?(target_position, board)
            previous_position = @position # Store the previous position
            @position = target_position
    
            if promotion_row?
                promoted_piece = promote_pawn
                puts "Before updating grid: #{board.grid[target_position[0]][target_position[1]].inspect}"
                board.grid[target_position[0]][target_position[1]] = promoted_piece
                puts "Immediately after promotion, grid[#{target_position[0]}, #{target_position[1]}]: #{board.grid[target_position[0]][target_position[1]].inspect}"
            else
                board.grid[target_position[0]][target_position[1]] = self
            end
    
            # Clear the previous position
            board.grid[previous_position[0]][previous_position[1]] = "."
    
            puts "After promotion and assignment, grid[#{target_position[0]}, #{target_position[1]}]: #{board.grid[target_position[0]][target_position[1]].inspect}"
    
            true
        else
            false
        end
    end
    
    
  
    ##########


    def to_s
        @symbol
    end


    private

 
    def valid_move?(target_position, board)
        current_row, current_col = @position
        new_row, new_col = target_position

        # First, check if the new position is within the bounds of the chessboard
        if new_row.between?(0, 7) && new_col.between?(0, 7)
            # Calculate row movement based on pawn color
            direction = @color == 'white' ? 1 : -1

            target_cell = board.grid[new_row][new_col]
        
            # Standard move: move forward to an empty space
            if new_col == current_col
                if new_row == current_row + direction
                    return true if target_cell == "."
                elsif new_row == current_row + 2 * direction && current_row == (color == 'white' ? 1 : 6)
                    # Allow double step on the first move
                    return true if target_cell == "." && board.grid[current_row + direction][current_col] == "."
                end
        
            # Capturing move: move diagonally to capture an opponent's piece
            elsif (new_col == current_col + 1 || new_col == current_col - 1) && new_row == current_row + direction
                return true if target_cell != "." && target_cell.is_a?(Piece) && target_cell.color != @color
            elsif en_passant?(target_position, board)
                return true
            end
        end

        false # if none of the conditions are met, the move is invalid
    end



    def en_passant?(target_position, board)
        current_row, current_col = @position
        new_row, new_col = target_position
        direction = @color == 'white' ? 1 : -1

        last_move = board.last_move

        if last_move
            start_pos, end_pos, piece = last_move
            # Ensure the last move was a two-square pawn move
            if piece.is_a?(Pawn) && (end_pos[0] - start_pos[0]).abs == 2
                # Check if the opponent's pawn is next to the current pawn
                if (end_pos[1] == current_col + 1 || end_pos[1] == current_col - 1) && end_pos[0] == current_row
                    # Verify that the target position is the square behind the opponent's pawn
                    if new_col == end_pos[1] && new_row == current_row + direction
                        # Capture the opponent's pawn via en passant
                        board.grid[end_pos[0]][end_pos[1]] = "."
                        return true
                    end
                end
            end
        end

        false
    end

    def promotion_row?
        (@color == 'white' && @position[0]==7) || (@color == 'black' && @position[0]==0)
    end

    def promote_pawn
        puts "Promote your pawn! Choose (Q)ueen, (R)ook, (B)ishop, or (K)night:"
        choice = gets.chomp.upcase
    
        case choice
        when 'Q'
            Queen.new(@color, @position)
        when 'R'
            Rook.new(@color, @position)
        when 'B'
            Bishop.new(@color, @position)
        when 'K'
            Knight.new(@color, @position)
        else
            puts "Invalid choice, promoting to Queen by default."
            Queen.new(@color, @position)
        end
    end
    



end

