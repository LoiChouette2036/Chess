class Piece

    attr_reader :color, :position

    def initialize(color,position)
        @color = color
        @position = position
    end

    def to_s 
        # Default representation if not overridden by subclass
        'X'
    end
end

#    def moves
#    end

#    def valid_moves
#    end

#    def move_to
#    end

#    def in_bounds?
#    end