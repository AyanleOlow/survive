extends CharacterBody3D

@export var speed: float = 1
var player: Node3D

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player:
		var direction_z = (player.global_position.z - global_position.z)
		var direction_x = (player.global_position.x - global_position.x)
		velocity.z = direction_z * speed
		velocity.x = direction_x * speed
		move_and_slide()
