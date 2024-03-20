extends Sprite2D

# Arrow pictures and names
var arrow_list = [
	{"path": "res://assets/arrow-right.png", "name": "arrow_right"},
	{"path": "res://assets/arrow-left.png", "name": "arrow_left"},
	{"path": "res://assets/arrow-up.png", "name": "arrow_up"},
	{"path": "res://assets/arrow-down.png", "name": "arrow_down"}
]

# Define a dictionary to map key codes to arrow names
var key_to_arrow = {
	KEY_UP: "arrow_up",
	KEY_DOWN: "arrow_down",
	KEY_RIGHT: "arrow_right",
	KEY_LEFT: "arrow_left"
}

# check if arrow has been hit
var hit = false
# add name for arrow
var current_arrow_name = ""

func _ready():
	generate_random_arrows()

# Determines which animation is played
func set_animation(name):
	if name == "topDown1":
		$AnimationPlayer.play("topDown1")
	elif name == "topDown2":
		$AnimationPlayer.play("topDown2")
	elif name == "topDown3":
		$AnimationPlayer.play("topDown3")
	elif name == "topDown4":
		$AnimationPlayer.play("topDown4")

# Generates random value from 4 different arrows
func generate_random_arrows():
	var random_arrow = arrow_list[randi_range(0, arrow_list.size() - 1)]
	texture = load(random_arrow["path"])
	current_arrow_name = random_arrow["name"]


# Checks how accurate user input was
func check_position_color():
	var area_color = ""
	if position.y >= 768 and position.y < 800:
		area_color = "red"
	elif position.y >= 800 and position.y < 832:
		area_color = "yellow"
	elif position.y >= 832 and position.y < 864:
		area_color = "green"
	elif position.y >= 864 and position.y < 896:
		area_color = "yellow"
	elif position.y >= 896 and position.y <= 928:
		area_color = "red"
		
	return area_color
	

func _process(delta):
	pass

## Takes user input from keyboard and checks if it matches current arrow
func _input(event):
	if event is InputEventKey and event.pressed:
		# Check that arrow is on "goal line" and that it's not already hit
		if position.y >= 768 and position.y <= 928 and not hit:
			var area = check_position_color()
			# Check if the pressed key matches the current arrow
			if key_to_arrow.has(event.keycode) and current_arrow_name == key_to_arrow[event.keycode]:
				print("Hit on ", area)
				hit = true
				texture = null
				$"/root/MainScene".increase_box_amount()
				# print feedback
				if area == "green":
					$"/root/MainScene".print_feedback("Perfect!")
					$"/root/MainScene".player_score(3)
				elif area == "yellow":
					$"/root/MainScene".print_feedback("Good!")
					$"/root/MainScene".player_score(2)
				elif area == "red":
					$"/root/MainScene".print_feedback("Poor")
					$"/root/MainScene".player_score(1)
