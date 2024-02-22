extends StaticBody2D


# brick ammount of hits before removing it
var hits = 1

# function that sets the ammount of hits before removing it
func set_hits(value):
	hits = value

# function that makes the brick take damage, returns if the brick is also
# destroyed or not
func take_damage():
	hits -= 1
	if hits == 0: 		# check if the brick is destroyed
		queue_free() 	# destroy the brick
		return true 	# return the brick was destroyed
	return false 		# return the brick is still going
