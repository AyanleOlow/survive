extends CharacterBody3D

@export var speed: float = 4.0
@export var health: int = 100

@onready var agent: NavigationAgent3D = $NavigationAgent3D

func _on_hitbox_body_entered(body):
	if body.is_in_group("bullet"):
		queue_free() # deletes the enemy instantly
		body.queue_free() # deletes the bullet too
		
		

func _on_area_3d_body_entered(body):
	if body.is_in_group("bullet"):
		body.queue_free()
		queue_free()
