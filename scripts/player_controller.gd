extends CharacterBody2D


const SPEED = 60 * 1.75


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

func _input(event):
	if global.game_state == global.GAME_STATE.game_over and event.is_action_released("player_1_start"):
		# Reset game
		get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
