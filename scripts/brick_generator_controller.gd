extends Node2D

var brick = preload("res://scenes/brick.tscn")

func _load(level):
	var file = FileAccess.open("res://levels/level" + str(level) + ".cfg", FileAccess.READ)
	if file != null:
		var content = file.get_as_text()
		return content
	else:
		print("Error reading file!")
		return null

func _build_level(level_string):
	var start = 0	# used to extract a line of level_string from 'start' to '\n', string start at '1'
	var dx = 0		# 'x' coordinate to position a new brick
	var dy = 0		# 'y' coordinate to position a new brick
	
	# Get the first line of the text
	print(level_string.length())
	print("BEGIN")
	
	var line = _get_line(level_string, start)
	
	# Iterate for each line, until the 'new line' char is read
	while start != level_string.length():
		print("STARTING CHAR: " + str(level_string[start]))
		line = _get_line(level_string, start)
		
		# Iterate for each character in 'line'
		for n in line.length():
			# Instantiate a new brick if a '1', '2' or '3' is read
			match line[int(n)]:
				"0":
					print(str(n) + ": Got 0... doing nothing")
				var brick_hits:
					print("Got 1, 2 or 3, building")
					# Instantiate a new brick
					var new_brick = brick.instantiate()
					
					# Calculate the new brick position
					print("START: " + str(start) + ", n: " + str(n))
					dx = 6 + (n * 8)
					dy = 4 + (int((start + n) / 15) * 4)
					print("BUILDING ON: (" + str(dx) + ", " + str(dy) + ")")
					new_brick.position = Vector2(dx, dy)
					new_brick.name = "brick" + str(start + n)
					new_brick.set_hits(int(brick_hits))
					
					# Add new brick as a child
					add_child(new_brick)
		# Add the new line position and read the next line
		print("NEW LINE")
		start += line.length() + 1
		print("STARTING POS: " + str(start))

func _get_line(string, starting_pos):
	print("GET LINE FROM: " + str(starting_pos))
	var i = starting_pos
	while string[i] != "\n":
		i += 1
	print("LINE GOT FROM " + str(starting_pos) + " to " + str(i) + ": " + string.substr(starting_pos, i - starting_pos))
	return string.substr(starting_pos, i - starting_pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	var level_string = _load(1)
	if level_string != null:
		_build_level(level_string)
		print("Level ready!")
	else:
		print("Error loading level!")
