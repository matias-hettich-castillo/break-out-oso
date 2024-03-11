extends CharacterBody2D

@onready var wall_bounce_sfx = $"../audio/wall_bounce_sfx"
@onready var paddle_bounce_sfx = $"../audio/paddle_bounce_sfx"

# Signals for handling score
signal brick_hit		# Signal for when the ball hits a brick
signal brick_destroy	# Signal for when the ball destroys a brick
signal player_miss		# Signal for when the ball falls down the screen

# Constant speed of the ball
const SPEED = 60

# Function that resets the position of the ball relative to the player position
func reset_ball():
	# Send the ball initially straight upwards
	velocity = Vector2(0,-SPEED)
	
	# Get the player node
	var player = get_node("../player")
	
	# Set the position of the ball relative to the player
	if player:
		position = player.position + Vector2(0, -4)

# Reset the ball's initial position when ready
func _ready():
	reset_ball()

# Handle the ball movement and collisions
func _physics_process(_delta):
	if global.game_state == global.GAME_STATE.playing:
		# Move the ball until it collides with something
		var collision = move_and_collide(velocity * _delta)
		
		# When the ball colides, check it
		if collision:
			# Obtain the collider of the collision
			var collider = collision.get_collider()
			
			# Check if the ball collided with the player
			if str(collider).contains("player"):
				print("player hit!")
				
				# Get the player node after collision
				var player = get_node("../player")
				
				# Calculate the distance from the center of the paddle
				var difference = position.x - player.position.x
				
				# Setting the bounce angle relative to distance from center
				velocity = Vector2(difference/7.5, -1)
				
				# Normalize the velocity vector
				velocity.normalized()
				
				# Set the ball constant speed
				velocity *= SPEED
				
				# Play the paddle_bounce_sfx
				paddle_bounce_sfx.play()
			
			# In case the ball collided with the wall or a brick
			else:
				# Handle brick collision
				#if str(collider).contains("brick"):
				if collider.is_in_group("bricks"):
					# Do damage to the brick collided
					var is_destroyed = collider.take_damage()
					
					# Check if the brick was destroyed or just hitted
					if is_destroyed:
						emit_signal("brick_destroy")
					else:
						print("Brick hit!")
						emit_signal("brick_hit")
				else:
					# Play the wall_bounce_sfx
					wall_bounce_sfx.play()
			
				# Get collision with horizontal collider
				if collision.get_normal() in [Vector2(0, 1), Vector2(0, -1)]:
					velocity *= Vector2(1, -1)
				# Get collision with vertical collider
				else:
					velocity *= Vector2(-1, 1)

# Function that triggers when the ball enters the player goal area
func _on_player_goal_body_entered(_body):
	print("player miss!")
	emit_signal("player_miss")
	reset_ball()
