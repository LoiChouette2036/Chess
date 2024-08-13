class Piece
    attr_reader :color, :position
  
    def initialize(color, position)
      @color = color
      @position = position
    end
  
    def move_piece(end_pos)
      @position = end_pos
    end
  
    def valid_moves(board)
      raise NotImplementedError, "This method should be overridden by subclasses"
    end
  
    def symbol
      raise NotImplementedError, "This method should be overridden by subclasses"
    end
  
    protected
  
    def on_board?(pos)
      pos.all? { |coord| coord.between?(0, 7) }
    end
  end
  
  class Pawn < Piece
    def symbol
      color == :white ? "\u2659" : "\u265F"
    end
  
    def valid_moves(board)
      direction = color == :white ? -1 : 1
      row, col = position
      possible_moves = []
  
      # Standard forward move
      forward_pos = [row + direction, col]
      if board[forward_pos].nil? && on_board?(forward_pos)
        possible_moves << forward_pos
  
        # Double forward move if pawn is in starting position
        start_row = color == :white ? 6 : 1
        double_forward_pos = [row + 2 * direction, col]
        if row == start_row && board[double_forward_pos].nil? && board[forward_pos].nil?
          possible_moves << double_forward_pos
        end
      end
  
      # Diagonal capture
      [-1, 1].each do |diagonal|
        diagonal_pos = [row + direction, col + diagonal]
        if on_board?(diagonal_pos) && board[diagonal_pos] && board[diagonal_pos].color != color
          possible_moves << diagonal_pos
        end
      end
  
      possible_moves
    end
  end
  
  class Rook < Piece
    def symbol
      color == :white ? "\u2656" : "\u265C"
    end
  
    def valid_moves(board)
      row, col = position
      possible_moves = []
  
      [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dx, dy|
        row_offset, col_offset = row + dx, col + dy
        while on_board?([row_offset, col_offset]) && board[[row_offset, col_offset]].nil?
          possible_moves << [row_offset, col_offset]
          row_offset += dx
          col_offset += dy
        end
  
        if on_board?([row_offset, col_offset]) && board[[row_offset, col_offset]].color != color
          possible_moves << [row_offset, col_offset]
        end
      end
  
      possible_moves
    end
  end
  
  class Knight < Piece
    def symbol
      color == :white ? "\u2658" : "\u265E"
    end
  
    def valid_moves(board)
      row, col = position
      possible_moves = []
  
      [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]].each do |dx, dy|
        new_pos = [row + dx, col + dy]
        if on_board?(new_pos) && (board[new_pos].nil? || board[new_pos].color != color)
          possible_moves << new_pos
        end
      end
  
      possible_moves
    end
  end
  
  class Bishop < Piece
    def symbol
      color == :white ? "\u2657" : "\u265D"
    end
  
    def valid_moves(board)
      row, col = position
      possible_moves = []
  
      [[1, 1], [1, -1], [-1, 1], [-1, -1]].each do |dx, dy|
        row_offset, col_offset = row + dx, col + dy
        while on_board?([row_offset, col_offset]) && board[[row_offset, col_offset]].nil?
          possible_moves << [row_offset, col_offset]
          row_offset += dx
          col_offset += dy
        end
  
        if on_board?([row_offset, col_offset]) && board[[row_offset, col_offset]].color != color
          possible_moves << [row_offset, col_offset]
        end
      end
  
      possible_moves
    end
  end
  
  class Queen < Piece
    def symbol
      color == :white ? "\u2655" : "\u265B"
    end
  
    def valid_moves(board)
      Rook.new(color, position).valid_moves(board) + Bishop.new(color, position).valid_moves(board)
    end
  end
  
  class King < Piece
    def symbol
      color == :white ? "\u2654" : "\u265A"
    end
  
    def valid_moves(board)
      row, col = position
      possible_moves = []
  
      [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]].each do |dx, dy|
        new_pos = [row + dx, col + dy]
        if on_board?(new_pos) && (board[new_pos].nil? || board[new_pos].color != color)
          possible_moves << new_pos
        end
      end
  
      possible_moves
    end
  end
  