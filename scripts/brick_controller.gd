extends StaticBody2D


# brick ammount of hits before removing it
var hits = 1
@onready var texture_brick_1 = preload("res://assets/graphics/brick_1.png")
@onready var texture_brick_2 = preload("res://assets/graphics/brick_2.png")
@onready var texture_brick_3 = preload("res://assets/graphics/brick_3.png")

# function that sets the ammount of hits before removing it
func set_hits(value):
	print("Setting hits value to: " + str(value))
	hits = value

# function that makes the brick take damage, returns if the brick is also
# destroyed or not
func take_damage():
	print("Take damage!")
	hits -= 1
	if hits == 0: 		# check if the brick is destroyed
		queue_free() 	# destroy the brick
		return true 	# return the brick was destroyed
	return false 		# return the brick is still going

func _process(_delta):
	# Check the remaining hits and match the brick texture to it
	match hits:
		3:	$Sprite2D.set_texture(texture_brick_3)
		2:	$Sprite2D.set_texture(texture_brick_2)
		1:	$Sprite2D.set_texture(texture_brick_1)
