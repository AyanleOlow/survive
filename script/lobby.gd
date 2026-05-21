extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_leave_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/menu.tscn")


func _on_join_room_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/join_room.tscn")


func _on_create_room_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/lobby.tscn")
