extends Node2D


var player_score = 0


func _on_ball_brick_destroy():
	player_score += 3
	print("Score: " + str(player_score))


func _on_ball_brick_hit():
	player_score += 1
	print("Score: " + str(player_score))
