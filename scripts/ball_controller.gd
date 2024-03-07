extends CharacterBody2D

# signals for handling score
signal brick_hit
signal brick_destroy
signal player_miss

const SPEED = 60

func _ready():
	reset_ball()

func _physics_process(_delta):
	
	var collision = move_and_collide(velocity * _delta)
	if collision:
		var collider = collision.get_collider()
		if str(collider).contains("player"):
			print("player hit!")
			# Get the player node after collision
			# Calculate the distance from the center of the paddle
			var player = get_node("../player")
			var difference = position.x - player.position.x
			
			# Determine the bounce direction
			var direction = 1 if difference > 0 else -1
			
			# Paddle bounce region limits
			var center_right = 1.3
			var far_right = 6
			var center_left = -center_right
			var far_left = -far_right
			
			# Paddle angles
			var small_angle = 0.1
			var medium_angle = 0.5
			var large_angle = 1.5
			
			# Set a bit of bounce angle in the center of the paddle
			if difference >= center_left and difference <= center_right:
				velocity = Vector2(small_angle, -1) * Vector2(direction, 1)
				velocity.normalized()
				velocity *= SPEED
				
			# Set some bounce angle in between the center and the sides
			elif (difference >= far_left and difference < center_left) or (difference > center_right and difference <= far_right):
				velocity = Vector2(medium_angle, -1) * Vector2(direction, 1)
				velocity.normalized()
				velocity *= SPEED
				
			# Set a lot of bounce angle on the sides of the paddle
			elif difference < far_left or difference > far_right:
				velocity = Vector2(large_angle, -1) * Vector2(direction, 1)
				velocity.normalized()
				velocity *= SPEED
				
		else:
			# Handle brick collision
			if str(collider).contains("brick"):
				var is_destroyed = collider.take_damage()
				if is_destroyed:
					emit_signal("brick_destroy")
				else:
					print("Brick hit!")
					emit_signal("brick_hit")
		
			# Get collision with horizontal collider
			if collision.get_normal() in [Vector2(0, 1), Vector2(0, -1)]:
				velocity *= Vector2(1, -1)
			# Get collision with vertical collider
			else:
				velocity *= Vector2(-1, 1)
	
func reset_ball():
	velocity = Vector2(SPEED,-SPEED)
	var player = get_node("../player")
	if player:
		position = player.position + Vector2(0, -4)

# Function that triggers when the ball enters the player goal area
func _on_player_goal_body_entered(_body):
	print("player miss!!!")
	emit_signal("player_miss")
	reset_ball()
