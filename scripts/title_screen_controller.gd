extends Node2D

func _input(event):
	# Start the game selected
	if event.is_action_released("player_1_start"):
		# Play start game soundfx
		#start_soundfx.play()
		
		# Wait for the sound to play
		#while start_soundfx.playing:
		#	pass
		
		# Start a new game
		get_tree().change_scene_to_file("res://scenes/main.tscn")
