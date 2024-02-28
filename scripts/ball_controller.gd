extends CharacterBody2D

# signals for handling score
signal brick_hit
signal brick_destroy

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
			
			# Set a bit of bounce angle in the center of the paddle
			if difference >= -1 and difference <= 1:
				velocity = Vector2(0.1, -1) * Vector2(direction, 1)
				velocity.normalized()
				velocity *= SPEED
				
			# Set some bounce angle in between the center and the sides
			elif (difference >= -6 and difference < -1) or (difference > 1 and difference <= 6):
				velocity = Vector2(0.75, -1) * Vector2(direction, 1)
				velocity.normalized()
				velocity *= SPEED
				
			# Set a lot of bounce angle on the sides of the paddle
			elif difference < -6 or difference > 6:
				velocity = Vector2(1.25, -1) * Vector2(direction, 1)
				velocity.normalized()
				velocity *= SPEED
				
		else:
			# Handle brick collision
			if str(collider).contains("brick"):
				var is_destroyed = collider.take_damage()
				if is_destroyed:
					emit_signal("brick_destroy")
				else:
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
	reset_ball()
