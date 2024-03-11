extends Node2D

# Music and audio
@onready var title_screen_mus = $audio/title_screen_mus
@onready var start_game_sfx = $audio/start_game_sfx

func _ready():
	title_screen_mus.play()

# Handle player input in title screen
func _input(event):
	# Start the game when the start button is released
	if event.is_action_released("player_1_start"):
		# Play start game soundfx
		start_game_sfx.play()
		
		# Wait for the sound to play
		while start_game_sfx.playing:
			pass
		
		# Start a new game
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		
		# Update the global game_state
		global.game_state = global.GAME_STATE.playing
