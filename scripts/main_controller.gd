extends Node2D

# Signals to handle player score, level and lives
signal update_score
signal update_level
signal update_lives

# Signal to load the next level
signal go_to_next_level

# Variables to handle player's score, level and lives
var player_score = 0
var player_level = 1
var player_lives = 3

# Variable to handle the remaining bricks of the level
var brick_counter = 0

# Check if the 'player_level' == 6 and 'brick_counter' == 0
func _process(_delta):
	if player_level == 6:
		# Set the game_state to game_won
		global.game_state = global.GAME_STATE.game_won
		
		# Remove the ball
		if $ball:
			$ball.queue_free()

# Triggers when the ball destroys a brick
func _on_ball_brick_destroy():
	# Give the player 3 points
	player_score += 3
	print("Score: " + str(player_score))
	
	# Update the hud score counter
	emit_signal("update_score", player_score)
	
	# Remove one brick from the brick_counter
	brick_counter -= 1
	
	# Check if all bricks where destroyed and load next level
	if brick_counter <= 0:
		# Give the player 5 points
		player_score += 5
		print("Score: " + str(player_score))
		
		# Update the hud score counter
		emit_signal("update_score", player_score)
	
		# Update the current player level
		player_level += 1
		
		# Update the hud level counter
		emit_signal("update_level", player_level)
		
		# Load next level
		emit_signal("go_to_next_level", int(player_level))

# Triggers when the ball hits a brick
func _on_ball_brick_hit():
	# Give the player 1 point
	player_score += 1
	print("Score: " + str(player_score))
	
	# Update the hud score counter
	emit_signal("update_score", player_score)

# Triggers when the ball falls under the play area
func _on_ball_player_miss():
	# Somehow there's a bug that removed 1 live from the player
	# at the begining of the game. For the moment (and forever I guess)
	# is fixed with this check
	if player_score > 0:
		if player_lives > 0:
			# Remove one live from the player
			player_lives -= 1
			print("Lives: " + str(player_lives))
			
			# Update the hud player lives counter
			emit_signal("update_lives", player_lives)
		else:
			# Set the game_state to game_over
			global.game_state = global.GAME_STATE.game_over
			
			# Remove the ball
			$ball.queue_free()

# Saves how many bricks are at the beggining of the current level
func _on_brick_generator_bricks_ready(bricks):
	brick_counter = bricks
