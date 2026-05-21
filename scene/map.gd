extends Node3D

func _process(delta):

	if Input.is_action_just_pressed("esc"):

		get_tree().change_scene_to_file("res://scene/menu.tscn")
		
