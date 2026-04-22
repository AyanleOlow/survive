extends CharacterBody3D

@export var speed: float = 1
@export var damage_number_scene: PackedScene

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

# 👇 CALL THIS WHEN THE ENEMY TAKES DAMAGE
func take_damage(amount: int):
	spawn_damage_number(amount)



# 👇 SPAWN DAMAGE NUMBER
func spawn_damage_number(amount: int):
	if damage_number_scene == null:
		return
	
	var dmg = damage_number_scene.instantiate()
	
	# spawn slightly above enemy
	dmg.global_position = global_position + Vector3(0, 2, 0)
	
	get_tree().current_scene.add_child(dmg)
	
	# call setup function from DamageNumber script
	dmg.setup(amount)
