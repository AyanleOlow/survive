extends Node3D

var enemies = []
var current_index = 0

func _ready():
	enemies = []

	for node in get_tree().get_nodes_in_group("enemy"):
		if node.name.to_lower().contains("enemy"):
			enemies.append(node)

	# disable only enemies
	for e in enemies:
		disable_enemy(e)

	spawn_next_enemy()
	# disable all enemies first
	for e in enemies:
		disable_enemy(e)

	spawn_next_enemy()

func spawn_next_enemy():
	if current_index >= enemies.size():
		print("ALL DONE")
		return

	var enemy = enemies[current_index]
	enable_enemy(enemy)

	enemy.tree_exited.connect(_on_enemy_died)

func _on_enemy_died():
	current_index += 1
	spawn_next_enemy()


func disable_enemy(enemy):
	enemy.hide()
	
	if enemy.has_node("CollisionShape3D"):
		enemy.get_node("CollisionShape3D").disabled = true


func enable_enemy(enemy):
	enemy.show()
	
	if enemy.has_node("CollisionShape3D"):
		enemy.get_node("CollisionShape3D").disabled = false
