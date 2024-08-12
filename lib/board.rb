require_relative 'pawn.rb'
require_relative 'rook.rb'
require_relative 'bishop.rb'
require_relative 'knight.rb'
require_relative 'king.rb'
require_relative 'queen.rb'

class Board

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
        @grid[0][0] = Rook.new('white',[0.0])
        @grid[0][7] = Rook.new('white',[0,7])
        #Place black rook
        @grid[7][0] = Rook.new('black',[7,0])
        @grid[7][7] = Rook.new('black',[7,7])

        # Place white bishop
        @grid[0][2]=Bishop.new('white',[0][2])
        @grid[0][5]=Bishop.new('white',[0][5])
        # Place black bishop
        @grid[7][2]=Bishop.new('black',[7][2])
        @grid[7][5]=Bishop.new('black',[7][5])

        #place white knights
        @grid[0][1]=Knight.new('white',[0][1])
        @grid[0][6]=Knight.new('white',[0][6])
        #place black knights
        @grid[7][1]=Knight.new('black',[7][1])
        @grid[7][6]=Knight.new('black',[7][6])

        #place kings
        @grid[0][4]=King.new('white',[0][4])
        @grid[7][4]=King.new('black',[7][4])
        #place black kings
        @grid[0][3]=Queen.new('white',[0][3])
        @grid[7][3]=Queen.new('black',[7][3])
        
    end

    def display
        @grid.each do |row|
            puts row.map { |cell| cell.is_a?(String) ? cell : cell.to_s }.join(" ")
        end
    end

end

board=Board.new
board.display