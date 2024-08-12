require_relative 'piece.rb'


class Queen < Piece
    attr_accessor :position
    attr_reader :color

    def initialize(color,position)
        super(color,position)
        @symbol = color == 'white' ? "\u2655" : "\u265B"
    end

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
    
    def valid_move?(target_position, board)
        current_row, current_col = @position
        new_row, new_col = target_position
      
        # Check if the move is within the bounds of the chessboard
        return false unless new_row.between?(0, 7) && new_col.between?(0, 7)
      
        # Check for diagonal, horizontal, or vertical movement
        row_difference = new_row - current_row
        col_difference = new_col - current_col
      
        if row_difference.abs == col_difference.abs # Diagonal movement
          return validate_path_and_target(current_row, current_col, new_row, new_col, board, :diagonal)
        elsif current_row == new_row || current_col == new_col # Horizontal or vertical movement
          return validate_path_and_target(current_row, current_col, new_row, new_col, board, :straight)
        else
          return false
        end
    end

    def validate_path_and_target(current_row, current_col, new_row, new_col, board, move_type)
        case move_type
        when :diagonal
          row_step = new_row > current_row ? 1 : -1
          col_step = new_col > current_col ? 1 : -1
      
          row, col = current_row + row_step, current_col + col_step
          while row != new_row && col != new_col
            return false unless board.grid[row][col] == "."
            row += row_step
            col += col_step
          end
      
        when :straight
          if current_row == new_row
            range = current_col < new_col ? (current_col + 1..new_col - 1) : (new_col + 1..current_col - 1)
            range.each { |col| return false unless board.grid[current_row][col] == "." }
          elsif current_col == new_col
            range = current_row < new_row ? (current_row + 1..new_row - 1) : (new_row + 1..current_row - 1)
            range.each { |row| return false unless board.grid[row][current_col] == "." }
          end
        end
      
        # Check the target cell
        target_cell = board.grid[new_row][new_col]
        return target_cell == "." || target_cell.color != @color
    end
      
    

end
