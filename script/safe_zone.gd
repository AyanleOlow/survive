extends Node3D


func _on_body_entered(body):
	if body.is_in_group("player"):
		print("player entered zone")

func _on_body_exited(body):
	if body.is_in_group("player"):
		print("player left zone")
