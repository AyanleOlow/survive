extends Node3D

@onready var interact_label = $interactText

var player_near = false

func _ready():
	interact_label.visible = false

func _process(delta):

	if player_near and Input.is_action_just_pressed("interact"):
		open_shop()

func _on_area_3d_body_entered(body):

	if body.name == "Player":
		player_near = true
		interact_label.visible = true

func _on_area_3d_body_exited(body):

	if body.name == "Player":
		player_near = false
		interact_label.visible = false

func open_shop():
	interact_label.visible = false
	get_tree().paused = true
	$ShopUI.open()
