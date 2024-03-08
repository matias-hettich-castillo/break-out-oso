extends Node2D

# Signals to handle when the brick are ready
signal bricks_ready

# Variables for the bricks to instantiate and remainin bricks counter
var brick = preload("res://scenes/brick.tscn")
var brick_counter = 0

# Function that loads a new level respective to a level_number
func load_level(level_number):
	# Load the new level 'level_string'
	var level_string = load_file(level_number)

	# level string error handling
	if level_string != null:
		build_level(level_string)
		emit_signal("bricks_ready", brick_counter)
		print("--- LEVEL " + str(level_number) + ": READY ---")
	else:
		print("--- ERROR: Level " + str(level_number) + " loading failed ---")

# This function is used to load the data of a level from a level file
# The levels are stored in '*.cfg' files in the '../levels' folder
# The leves are named with the convention 'level' + level_number + '.cfg'
func load_file(level):
	var file = FileAccess.open("res://levels/level" + str(level) + ".cfg", FileAccess.READ)
	if file != null:
		var content = file.get_as_text()
		return content
	else:
		print("Error reading file!")
		return null

# Function that builds a level from a 'level_string'
# The 'level_string' has rows of 14 digits between 0 and 3 where:
#	  0: There's no brick in that position
#	1-3: There's a brick in that position with '1-3' lives or hits
func build_level(level_string):
	print("--- BUILDING LEVEL ---")
	brick_counter = 0	# used to count the remaining bricks in the level
	var line = ""		# used to store a line from the level_string
	var start = 0		# used to extract a line of level_string from 'start' to '\n'
	var dx = 0			# 'x' coordinate to position a new brick
	var dy = 0			# 'y' coordinate to position a new brick
	
	# Iterate for each line, until 'start' is equal to the 'level_string' length 
	while start != level_string.length():
		# Get the next line of the 'level_string'
		line = get_line(level_string, start)
		
		# Iterate for each character in 'line'
		for n in line.length():
			# Instantiate a new brick if a '1', '2' or '3' is read
			match line[int(n)]:
				"0":
					# Skip space on '0'
					print(str(n) + ": Got 0... skipping")
				
				var brick_hits:
					# Instantiate a new brick
					var new_brick = brick.instantiate()
					
					# Calculate the new brick position:
					#	the bricks are 8x4 pixels in size
					#	the first space goes on (6, 4)
					#	'n' has the current char in the line
					#	'start' has the current line in the 'level_string'
					dx = 6 + (n * 8)
					dy = 4 + (int((start + n) / 15) * 4)
					print(str(n) + ": BUILDING ON: (" + str(dx) + ", " + str(dy) + ") WITH: " + str(brick_hits) + " HIT(S)")
					
					# Set the new brick position, name and hits
					new_brick.position = Vector2(dx, dy)
					new_brick.name = "brick" + str(start + n)
					new_brick.set_hits(int(brick_hits))
					
					# Add new brick as a child of this node
					add_child(new_brick)
					
					# Add one to the bricks counter
					brick_counter += 1
		
		# Add the new line position and read the next line
		start += line.length() + 1
		print()
	print("--- BUILDING DONE ---\n")

# Function that gets a line from starting_pos until it reaches a '\n'
func get_line(string, starting_pos):
	# Set a char position counter
	var i = starting_pos
	
	# Add 1 to the char counter until it reaches a '\n'
	while string[i] != "\n":
		i += 1
	
	# Substract the line from the 'string' from 'starting_pos' to 'i'
	var line = string.substr(starting_pos, i - starting_pos)
	print("LINE from " + str(starting_pos) + " to " + str(i) + ": " + line)
	return line

# Called when the node enters the scene tree for the first time.
func _ready():
	# Load the first level of the game each time the player begins a new game
	load_level(1)

# Function that triggers when the player destroys every brick of a level
func _on_main_go_to_next_level(next_level):
	load_level(next_level)
