extends Node3D

@onready var label: Label3D = $Label3D


var velocity := Vector3.ZERO

func setup(damage: int):
	label.text = str(damage)

	# random little spread so numbers don't overlap
	velocity = Vector3(
		randf_range(-0.5, 0.5),
		randf_range(1.5, 2.5),
		randf_range(-0.5, 0.5)
	)

func _process(delta):
	translate(velocity * delta)

func _on_animation_player_animation_finished(anim_name):
	queue_free()
