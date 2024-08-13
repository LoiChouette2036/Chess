class Game
    attr_reader :board, :current_player
  
    def initialize
      @board = Board.new
      @current_player = :white
    end
  
    def play
      loop do
        display_board
        start_pos, end_pos = get_move
        begin
          @board.move_piece(start_pos, end_pos)
          switch_player
        rescue => e
          puts e.message
        end
      end
    end
  
    private
  
    def display_board
      puts "  0 1 2 3 4 5 6 7"
      @board.grid.each_with_index do |row, i|
        print "#{i} "
        row.each do |piece|
          print piece.nil? ? "- " : "#{piece.symbol} "
        end
        puts
      end
    end
  
    def get_move
      puts "#{current_player.capitalize}, enter your move:"
      print "Start position (row column): "
      start_pos = gets.chomp.split.map(&:to_i)
      print "End position (row column): "
      end_pos = gets.chomp.split.map(&:to_i)
      [start_pos, end_pos]
    end
  
    def switch_player
      @current_player = @current_player == :white ? :black : :white
    end
  end
  