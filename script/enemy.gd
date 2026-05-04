extends CharacterBody3D

@export var speed: float = 4.0
@export var health: int = 100
@export var damage_number_scene: PackedScene

@onready var agent: NavigationAgent3D = $NavigationAgent3D

func take_damage(amount: int):
	health -= amount

	if health <= 0:
		die()

func die():
	queue_free()
