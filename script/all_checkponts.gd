extends Node3D

var enemies = []
var current_index = 1

func _ready():
	enemies = get_tree().get_nodes_in_group("enemy")

	# hide all enemies first
	for e in enemies:
		e.visible = false

	spawn_next_enemy()

func spawn_next_enemy():
	if current_index >= enemies.size():
		print("All enemies defeated!")
		return

	var enemy = enemies[current_index]
	enemy.visible = true

	# connect death
	enemy.tree_exited.connect(_on_enemy_died)

func _on_enemy_died():
	current_index += 1
	spawn_next_enemy()
