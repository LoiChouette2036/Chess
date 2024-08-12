#3. Class: Player (Base Class)
#Attributes:
#name: Player's name.
#color: The color of the player's pieces (white or black).
#Methods:
#make_move: Abstract method to be implemented by subclasses.
class Player 

    def initialize
        puts "what's your name : "
        @name = gets.chomp
        loop do
            puts "do you want to play white or black ? : "
            choice =gets.chomp.downcase
            case choice
            when "white", "black"
                @color = choice
                break
            else
                puts "invalid choice, try again"
            end
        end
    end

    def make_move
        valid_pieces = ["rook", "knight", "bishop", "king", "queen", "pawn"]

        loop do
            puts "Choose your next move: Which piece? (rook, knight, bishop, king, queen, pawn)"
            piece = gets.chomp.downcase

            if valid_pieces.include?(piece)
                puts "You chose the #{piece}."
                break
            else
                puts "Invalid choice, please select from the following: rook, knight, bishop, king, queen, pawn."
            end
        end

        puts "now choose your target position ([x,y]) : "
        puts "your row : "
        row=gets.chomp
        puts "your column : "
        col = gets.chomp

        @target_position = [row,col]


    end

end
