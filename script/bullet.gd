extends CharacterBody3D
func _physics_process(delta: float) -> void:
	global_position = global_transform.origin + -global_transform.basis.z * 1.0
