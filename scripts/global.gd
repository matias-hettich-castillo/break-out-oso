extends Node

# Enum to handle current game state options
enum GAME_STATE {
	playing,
	game_over,
	game_won
}

# Variable to handle current game state
var game_state = GAME_STATE.playing
