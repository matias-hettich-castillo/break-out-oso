extends CharacterBody2D

# Constant speed for the paddle movement
const SPEED = 60 * 1.75

# Handle the movement of the player's paddle
# Collide with the sides of the game area
func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if global.game_state == global.GAME_STATE.playing:
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED * _delta
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * _delta)
		move_and_collide(velocity)

# Handle player inputs
func _input(event):
	# Handle reset button player input
	if event.is_action_released("player_1_reset"):
		get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
	
	# Handle start button when a game_over happens to reset game
	if global.game_state != global.GAME_STATE.playing and event.is_action_released("player_1_start"):
		get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
