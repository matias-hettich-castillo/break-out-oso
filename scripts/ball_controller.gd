extends CharacterBody2D


const SPEED = 60
var starting_position = position

func _ready():
	reset_ball()

func _physics_process(_delta):
	var collision = move_and_collide(velocity * _delta)
	if collision:
		# Check if the collision was with a player or a wall/brick
		# Player collision is handled differently
		
		# Get collision with horizontal collider
		if collision.get_normal() in [Vector2(0, 1), Vector2(0, -1)]:
			velocity *= Vector2(1, -1)
		# Get collision with vertical collider
		else:
			velocity *= Vector2(-1, 1)
	
func reset_ball():
	#velocity = Vector2(1,-1).normalized()
	velocity = Vector2(SPEED,-SPEED)
	position = starting_position

# Function that triggers when the ball enters the player goal area
func _on_player_goal_body_entered(_body):
	reset_ball()
