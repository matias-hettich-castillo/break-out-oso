extends Node2D

signal update_score
signal update_level
signal update_lives

signal game_over

var player_score = 0
var player_lives = 3
var player_level = 1

func _on_ball_brick_destroy():
	player_score += 3
	print("Score: " + str(player_score))
	emit_signal("update_score", player_score)


func _on_ball_brick_hit():
	player_score += 1
	print("Score: " + str(player_score))
	emit_signal("update_score", player_score)


func _on_ball_player_miss():
	# Fix bug that removed a live on level 1 start
	if player_score > 0:
		if player_lives > 0:
			player_lives -= 1
			print("Lives: " + str(player_lives))
			emit_signal("update_lives", player_lives)
		else:
			# Game over
			global.game_state = global.GAME_STATE.game_over
			emit_signal("game_over")
			$ball.queue_free()

# Updates the values of game data to the hud
func _on_game_data_get_values():
	emit_signal("update_level")
	emit_signal("update_lives")
	emit_signal("update_score")
