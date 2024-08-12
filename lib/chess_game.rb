#1. Class: ChessGame
#Attributes:
#board: Represents the state of the chessboard.
#current_player: Tracks whose turn it is (white or black).
#players: Stores player objects (could be Human or AI).
#move_history: A log of all moves made during the game.
#Methods:
#initialize: Sets up the initial game state.
#play: Main game loop that alternates turns between players.
#switch_turns: Switches the current_player after each move.
#checkmate?: Checks if the current player is in checkmate.#
#stalemate?: Checks if the game is in a stalemate.
#draw?: Checks for other draw conditions (e.g., repetition, insufficient material).
#end_game: Ends the game and declares the result.