extends Control

signal  dialogue0_over

@onready var continue_btn = $ContinueBtn
@onready var skip_btn = $SkipBtn
@onready var start_btn = $StartDialogBtn

# Called when the node enters the scene tree for the first time.
func _ready():
	continue_btn.visible = false
	dialogue0_over.connect(on_dialogue0_over)


func on_dialogue0_over():
	continue_btn.visible = true
	skip_btn.visible = false
	
func start_dialogue():
	DialogueManager.show_dialogue_balloon(load("res://dialogues/first_scene.dialogue"), "start")

func _on_continue_btn_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")



func _on_skip_btn_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_start_dialog_btn_pressed():
	start_dialogue()
	skip_btn.visible = false
	start_btn.visible = false
	
