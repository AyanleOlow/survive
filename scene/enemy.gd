extends CharacterBody3D

@export var speed: float = 4.0
@export var health: int = 100
@export var damage_number_scene: PackedScene

@onready var agent: NavigationAgent3D = $NavigationAgent3D

var player: Node3D
var player_detected: bool = false

func _physics_process(delta: float) -> void:
	if player_detected:
		pass

func take_damage(amount: int):
	health -= amount
	spawn_damage_number(amount)

	if health <= 0:
		die()

func die():
	queue_free()


func spawn_damage_number(amount: int):
	if damage_number_scene == null:
		return
	
	var dmg = damage_number_scene.instantiate()
	dmg.global_position = global_position + Vector3(0, 2, 0)
	get_tree().current_scene.add_child(dmg)
	dmg.setup(amount)


func _on_detection_zone_body_entered(body: Node3D) -> void:
	true
