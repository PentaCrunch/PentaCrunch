extends Node2D

var arrow_scene = preload("res://arrow.tscn")

func _ready():
	pass


func send_arrows(animation_name, color):
		var arrow_instance = arrow_scene.instantiate()
		arrow_instance.generate_random_arrows(color)
		arrow_instance.set_animation(animation_name)
		
		add_child(arrow_instance)
