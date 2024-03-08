extends Node2D

# Handle player input in title screen
func _input(event):
	# Start the game when the start button is released
	if event.is_action_released("player_1_start"):
		# Play start game soundfx
		#start_soundfx.play()
		
		# Wait for the sound to play
		#while start_soundfx.playing:
		#	pass
		
		# Start a new game
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		
		# Update the global game_state
		global.game_state = global.GAME_STATE.playing
