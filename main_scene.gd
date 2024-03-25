extends Node

# How many arrows will be sended per line
var arrow_amount = 10
var arrow_amount2 = 5

# 12 * 5
var max_boxes = 60

# time between each arrow
var timer1 = 3
var timer2 = 1.125
var timer3 = 3
var timer4 = 3

var boxes = 0

# Max_score is 3x sended arrows for example 20 arrows -> max 60p
var max_score = 180
# Player score
var score = 0


@onready var boss_sprite = $Boss/Boss


@onready var truck_sprite = $Truck/Truck

var truck_texture1 = preload("res://assets/truck/truck-1.png")
var truck_texture2 = preload("res://assets/truck/truck-2.png")
var truck_texture3 = preload("res://assets/truck/truck-3.png")
var truck_texture4 = preload("res://assets/truck/truck-4.png")
var truck_texture5 = preload("res://assets/truck/truck-5.png")
var truck_texture6 = preload("res://assets/truck/truck-6.png")

@onready var feedback_label = $FeedbackLabel
@onready var percent_label = $PercentLabel
@onready var level_completed = $LevelCompLabel
@onready var level_failed = $LevelFailLabel
@onready var track = $Track
@onready var reverse_sound = $ReverseSound

@onready var arrow_child = get_node("ArrowMechanics")

func _ready():
	# set label empty 
	feedback_label.text = ""
	percent_label.text = ""
	level_completed.visible = false
	level_failed.visible = false
	reverse_sound.play()
	
	play_track()
	game_over()
	boss_sprite.play("grab_truck")
	$Truck/Truck/AnimationPlayer.play("reverse")
	$Boss/Boss/AnimationPlayer.play("reverse")
	$Truck/Truck/Door/AnimationPlayer.play("door_open")
	#use ArrowsMechanics to get arrow
	progression1()
	await get_tree().create_timer(12).timeout
	progression1()
	await get_tree().create_timer(12).timeout
	progression1()
	await get_tree().create_timer(12).timeout
	progression1()
	await get_tree().create_timer(12).timeout
	progression1()
	

func progression1():
	call_arrowsTopDown1(arrow_child)
	call_arrowsTopDown2(arrow_child)
	call_arrowsTopDown3(arrow_child)
	call_arrowsTopDown4(arrow_child)


func play_track():
	await get_tree().create_timer(3).timeout
	boss_sprite.play("neutral")
	track.play()

func call_arrowsTopDown1(arrow_child): 
	var index = 0
	if arrow_child:
		for i in range (5):
			print(i)
			# use send_arrows function to get arrow
			if i < 1:
				arrow_child.send_arrows("topDown1", "yellow")
			elif i < 2:
				arrow_child.send_arrows("topDown1", "lime")
			elif i < 3:
				arrow_child.send_arrows("topDown1", "pink")
			else:
				arrow_child.send_arrows("topDown1", "blue")
			if index < 3:
				await get_tree().create_timer(3).timeout
				index += 1
			else:
				await get_tree().create_timer(1.125).timeout
				
	else:
		print("Arrow child not found!")

func call_arrowsTopDown2(arrow_child):
	await get_tree().create_timer(4).timeout
	var index = 0
	if arrow_child:
		for i in range (2):
			# use send_arrows function to get arrow
			if i < 1:
				arrow_child.send_arrows("topDown2", "lime")
			else:
				arrow_child.send_arrows("topDown2", "blue")
				
			await get_tree().create_timer(7.5).timeout
			# time between
			
	else:
		print("Arrow child not found!")
	#set timer to wait last arrow and after that call game over function

func call_arrowsTopDown3(arrow_child):
	await get_tree().create_timer(6).timeout
	var index = 0
	if arrow_child:
		for i in range (3):
			# use send_arrows function to get arrow
			if i < 2:
				arrow_child.send_arrows("topDown3", "pink")
			else:
				arrow_child.send_arrows("topDown3", "blue")
				
			if index < 1:
				# time between
				await get_tree().create_timer(0.931).timeout
				index += 1
			else:
				await get_tree().create_timer(4.25).timeout
				


	else:
		print("Arrow child not found!")

func call_arrowsTopDown4(arrow_child):
	await get_tree().create_timer(6.56).timeout
	var index = 0
	if arrow_child:
		for i in range (2):
			# use send_arrows function to get arrow
			arrow_child.send_arrows("topDown4", "pink")
			if index < 1:
				await get_tree().create_timer(0.74).timeout
				index += 1
			else:
				await get_tree().create_timer(1.3).timeout

	else:
		print("Arrow child not found!")

func game_over():
	# timer for song (60) + 6 sec delay
	await get_tree().create_timer(63).timeout
	calculate_percent(score)
	track.stop()
	$Truck/Truck/Door/AnimationPlayer.play("door_close")
	await get_tree().create_timer(3).timeout
	boss_sprite.play("grab_truck")
	$Boss/Boss/AnimationPlayer.play("drive_away")
	$Truck/Truck/AnimationPlayer.play("drive_away")

func print_feedback(feedback):
	feedback_label.text = feedback
	if feedback == "Perfect!":
		boss_sprite.play("happy")
	elif feedback == "Good!":
		boss_sprite.play("neutral")
	elif feedback == "Poor":
		boss_sprite.play("stressed")

func player_score(points):
	score += points
	
func calculate_percent(score):
	var percent = float(score) / max_score * 100
	percent = snapped(percent, 0.01) # Rounds two deciamals
	percent_label.text = str(percent) + " %"
	if percent > 80:
		level_completed.visible = true
	else:
		level_failed.visible = true
	
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

