extends Node

# How many arrows will be sended per line
var arrow_amount = 10
var max_boxes = 20

# time between each arrow
var timer1 = 1.5
var timer2 = 2

var boxes = 0

# Max_score is 3x sended arrows for example 20 arrows -> max 60p
var max_score = 60
# Player score
var score = 0

@onready var truck_sprite = $Truck/Truck

var truck_texture1 = preload("res://assets/truck-1.png")
var truck_texture2 = preload("res://assets/truck-2.png")
var truck_texture3 = preload("res://assets/truck-3.png")
var truck_texture4 = preload("res://assets/truck-4.png")
var truck_texture5 = preload("res://assets/truck-5.png")
var truck_texture6 = preload("res://assets/truck-6.png")


@onready var feedback_label = $FeedbackLabel
@onready var percent_label = $PercentLabel

@onready var track = $Track

func _ready():
	# set label empty 
	feedback_label.text = ""
	percent_label.text = ""
	#use ArrowsMechanics to get arrow
	var arrow_child = get_node("ArrowMechanics")
	call_arrowsTopDown1(arrow_child)
	call_arrowsDownTop1(arrow_child)
	play_track()
	
func play_track():
	await get_tree().create_timer(3).timeout
	track.play()

func call_arrowsTopDown1(arrow_child):
	if arrow_child:
		for i in range (arrow_amount):
			# use send_arrows function to get arrow
			arrow_child.send_arrows("topDown1")
			# time between
			await get_tree().create_timer(timer1).timeout
	else:
		print("Arrow child not found!")

func call_arrowsDownTop1(arrow_child):
	if arrow_child:
		for i in range (arrow_amount):
			# use send_arrows function to get arrow
			arrow_child.send_arrows("downTop1")
			# time between
			await get_tree().create_timer(timer2).timeout
	else:
		print("Arrow child not found!")
	#set timer to wait last arrow and after that call game over function
	await get_tree().create_timer(0.5).timeout
	game_over()

func game_over():
	calculate_percent(score)

func print_feedback(feedback):
	feedback_label.text = feedback

func player_score(points):
	score += points
	
func calculate_percent(score):
	var percent = float(score) / max_score * 100
	percent = snapped(percent, 0.01) # Rounds two deciamals
	percent_label.text = str(percent) + " %"
	
func increase_box_amount():
	boxes += 1
	
	var percent = float(boxes) / max_boxes * 100
	percent = snapped(percent, 0)
	if percent > 85:
		truck_sprite.texture = truck_texture6
	elif percent > 71:
		truck_sprite.texture = truck_texture5
	elif percent > 57:
		truck_sprite.texture = truck_texture4
	elif percent > 42:
		truck_sprite.texture = truck_texture3
	elif percent > 28:
		truck_sprite.texture = truck_texture2
	elif percent > 14:
		truck_sprite.texture = truck_texture1

