extends Node

# How many arrows will be sended per line
var arrow_amount = 10
var arrow_amount2 = 5

signal dialogue_over
signal knock

# 12 * 5
var max_boxes = 60

var temp = ""

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

@onready var box = $Box/Sprite2D

@onready var accuracy_bar = $AccuracyBar/TextureRect

@onready var truck_sprite = $Truck/Truck

var truck_texture1 = preload("res://assets/truck/v2truck-1.png")
var truck_texture2 = preload("res://assets/truck/v2truck-2.png")
var truck_texture3 = preload("res://assets/truck/v2truck-3.png")
var truck_texture4 = preload("res://assets/truck/v2truck-4.png")
var truck_texture5 = preload("res://assets/truck/v2truck-5.png")
var truck_texture6 = preload("res://assets/truck/v2truck-6.png")
var truck_textureRev = preload("res://assets/truck/truck-reverse-empty.png")
var truck_textureEmp = preload("res://assets/truck/v2truck-empty.png")
var truck_textureDriv = preload("res://assets/truck/truck-drive.png")

# Labels
@onready var feedback_label = $FeedbackLabel
@onready var percent_label = $PercentLabel
@onready var level_completed = $LevelCompLabel
@onready var level_failed = $LevelFailLabel
@onready var count_down_label = $CountDownLabel

# Sounds
@onready var track = $Track
@onready var reverse_sound = $ReverseSound
@onready var truck_door_open = $TruckDoorOpening
@onready var truck_door_close = $TruckDoorClosing
@onready var drive_way_sound = $DriveAwaySound
@onready var knock_sound = $KnockSound

@onready var arrow_child = get_node("ArrowMechanics")

func _ready():
	truck_sprite.texture = truck_textureRev
	dialogue_over.connect(on_dialogue_over)
	knock.connect(on_knock)
	feedback_label.text = ""
	percent_label.text = ""
	level_completed.visible = false
	level_failed.visible = false
	accuracy_bar.visible = false
	count_down_label.visible = false
	reverse_sound.play()
	truck_sprite.texture = truck_textureRev
	
	boss_sprite.play("grab_truck")
	$Truck/Truck/AnimationPlayer.play("reverse")
	$Boss/Boss/AnimationPlayer.play("reverse")
	$Truck/Truck/Door/AnimationPlayer.play("door_open")
	truck_door_open.play()
	change_reverse()
	await get_tree().create_timer(3).timeout
	truck_sprite.texture = truck_textureEmp
	boss_sprite.play("still")
	start_dialogue()


func change_reverse():
	await get_tree().create_timer(0.5).timeout
	truck_sprite.texture = truck_textureEmp
	await get_tree().create_timer(0.4).timeout
	truck_sprite.texture = truck_textureRev
	await get_tree().create_timer(0.4).timeout
	truck_sprite.texture = truck_textureEmp
	await get_tree().create_timer(0.4).timeout
	truck_sprite.texture = truck_textureRev
	await get_tree().create_timer(0.4).timeout
	truck_sprite.texture = truck_textureEmp
	await get_tree().create_timer(0.4).timeout
	truck_sprite.texture = truck_textureRev

func progression1():
	call_arrowsTopDown1(arrow_child)
	call_arrowsTopDown2(arrow_child)
	call_arrowsTopDown3(arrow_child)
	call_arrowsTopDown4(arrow_child)

func call_progressions():
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

func start_dialogue():
	DialogueManager.show_dialogue_balloon(load("res://dialogues/at_hannah.dialogue"), "start")
	
func on_dialogue_over():
	start_game()
	
func on_knock():
	knock_sound.play()
	
func count_down():
	count_down_label.visible = true
	await get_tree().create_timer(1).timeout
	count_down_label.text = "2"
	await get_tree().create_timer(1).timeout
	count_down_label.text = "1"
	await get_tree().create_timer(1).timeout
	count_down_label.text = "Go!"
	await get_tree().create_timer(0.5).timeout
	count_down_label.visible = false

func start_game():
	game_over()
	call_progressions()
	accuracy_bar.visible = true
	boss_sprite.play("neutral")
	$Box/Sprite2D/AnimationPlayer.play("moving")
	count_down()
	await get_tree().create_timer(3).timeout
	track.play()


func call_arrowsTopDown1(arrow_child): 
	var index = 0
	if arrow_child:
		for i in range (4):
			# use send_arrows function to get arrow
			if i < 1:
				arrow_child.send_arrows("topDown1", "yellow")
			elif i < 2:
				arrow_child.send_arrows("topDown1", "lime")
			else:
				arrow_child.send_arrows("topDown1", "blue")
			if index < 1:
				await get_tree().create_timer(3).timeout
				index += 1
			elif index < 2:
				await get_tree().create_timer(6).timeout
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
				
			await get_tree().create_timer(7.4).timeout
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
	# timer for song (60) + 3 sec delay
	await get_tree().create_timer(63).timeout
	calculate_percent(score)
	feedback_label.visible = false
	track.stop()
	
	$Truck/Truck/Door/AnimationPlayer.play("door_close")
	truck_door_close.play()
	await get_tree().create_timer(3).timeout
	drive_way_sound.play()
	truck_sprite.texture = truck_textureDriv
	boss_sprite.play("grab_truck")
	$Boss/Boss/AnimationPlayer.play("drive_away")
	$Truck/Truck/AnimationPlayer.play("drive_away")

func print_feedback(feedback):
	feedback_label.text = feedback
	
	if feedback == "Perfect!":
		boss_sprite.play("happy")
	elif feedback == "Good!":
		boss_sprite.play("neutral")
	elif feedback == "Poor" and temp == "Poor":
		boss_sprite.play("angry")
	elif feedback == "Miss":
		boss_sprite.play("angry")
	elif feedback == "Poor":
		boss_sprite.play("stressed")
	temp = feedback

func player_score(points):
	score += points
	
func calculate_percent(score):
	var percent = float(score) / max_score * 100
	percent = snapped(percent, 0.01) # Rounds two deciamals
	percent_label.text = str(percent) + " %"
	if percent >= 60:
		level_completed.visible = true
		boss_sprite.play("happy")
	else:
		level_failed.visible = true
		boss_sprite.play("neutral")
	
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

func _on_retrun_btn_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
