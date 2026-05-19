extends CharacterBody3D

@onready var kills_label = get_node("/root/map/Player/CanvasLayer/killsLabel")

func _on_area_3d_body_entered(body):

	print("TOUCHED")

	if body.is_in_group("bullet"):

		print("BULLET HIT")

		Globals.kills += 1

		kills_label.text = "KILLS: " + str(Globals.kills)

		body.queue_free()
