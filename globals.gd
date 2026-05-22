extends Node


func _process(delta):
	pass
	
		

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		
		get_tree().change_scene_to_file("res://scene/menu.tscn")
