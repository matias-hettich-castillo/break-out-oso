extends CharacterBody2D


const SPEED = 60 * 1.75


func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED * _delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * _delta)

	move_and_collide(velocity)
