extends Label

signal get_values

# Stores the game's data
var gd_level = 1
var gd_score = 0
var gd_lives = 3

# Called to update the current level
func _update_level(level):
	gd_level = level

# Called to update the remaining lives
func _update_lives(lives):
	gd_lives = lives

func _ready():
	emit_signal("get_values")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if global.game_state == global.GAME_STATE.playing:
		text = "Level\n" + str(gd_level) + "\n\nScore\n" + str(gd_score) + "\n\nLives\n" + str(gd_lives)
	else:
		text = "Game\nOver\n\nPress\nStart"

# Updates the player score
func _on_main_update_score(score):
	gd_score = score

# Updates the player lives
func _on_main_update_lives(lives):
	gd_lives = lives

# Updates the player level
func _on_main_update_level(level):
	gd_level = level
