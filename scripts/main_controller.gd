extends Node2D

@onready var brick_hit_sfx = $audio/brick_hit_sfx
@onready var brick_break_sfx = $audio/brick_break_sfx
@onready var player_miss_sfx = $audio/player_miss_sfx
@onready var game_over_sfx = $audio/game_over_sfx
@onready var game_won_mus = $audio/game_won_mus
@onready var level_up_sfx = $audio/level_up_sfx

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
		
		# Play the game_won_mus
		if !game_won_mus.playing:
			game_won_mus.play()

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
		
		# Play the level_up_sfx
		level_up_sfx.play()
	else:
		# Play the brick_destroy_sfx
		brick_break_sfx.play()

# Triggers when the ball hits a brick
func _on_ball_brick_hit():
	# Give the player 1 point
	player_score += 1
	print("Score: " + str(player_score))
	
	# Update the hud score counter
	emit_signal("update_score", player_score)
	
	# Play the brick_hit_sfx
	brick_hit_sfx.play()

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
			
			# Play the player_miss_sfx
			player_miss_sfx.play()
		else:
			# Set the game_state to game_over
			global.game_state = global.GAME_STATE.game_over
			
			# Remove the ball
			$ball.queue_free()
			
			# Play the game_over_sfx
			game_over_sfx.play()

# Saves how many bricks are at the beggining of the current level
func _on_brick_generator_bricks_ready(bricks):
	brick_counter = bricks
