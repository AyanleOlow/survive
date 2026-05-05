extends Area3D

@export var speed: float = 20
@export var damage: int = 100

func _ready():
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	global_position += -global_transform.basis.z * speed * delta

func _on_body_entered(body):
	print("HIT:", body.name)

	var target = body

	while target != null:
		print("CHECKING:", target.name)  # 👈 IMPORTANT
		
		if target.is_in_group("enemy"):
			print("FOUND ENEMY:", target.name)

			if target.has_method("take_damage"):
				target.take_damage(100)

			queue_free()
			return
		
		target = target.get_parent()
		
	queue_free()
