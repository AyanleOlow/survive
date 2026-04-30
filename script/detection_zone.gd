extends Area3D

@export var damage: int = 3
@export var damage_interval: float = 1.0

var player_inside: Node3D = null
var timer: float = 0.0


func _physics_process(delta):
	if player_inside:
		timer -= delta
		
		if timer <= 0:
			timer = damage_interval
			
			if player_inside.has_method("take_damage"):
				player_inside.take_damage(damage)


func _on_body_entered(body):
	if body.is_in_group("player"):
		player_inside = body


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_inside = null
