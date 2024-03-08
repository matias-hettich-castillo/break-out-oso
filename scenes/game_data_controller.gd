extends Label

# Variables for the game data
var gd_level = 1
var gd_score = 0
var gd_lives = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Update the hud string to show the game data
	if global.game_state == global.GAME_STATE.playing:
		text = "Level\n" + str(gd_level) + "\n\nScore\n" + str(gd_score) + "\n\nLives\n" + str(gd_lives)
	
	# Show the "You win" screen in case the game_state is game_won
	elif global.game_state == global.GAME_STATE.game_won:
		text = "YOU\nWIN\n\nPress\nStart"
	
	# Show a game over screen in case the game_state is game_over
	else:
		text = "Game\nOver\n\nPress\nStart"

# Updates the player score
func _on_main_update_score(score):
	gd_score = score

# Updates the player lives
func _on_main_update_lives(lives):
	gd_lives = lives

# Updates the player level
func _on_main_update_level(level):
	gd_level = level
