extends Area3D

@export var speed: float = 20
@export var damage: int = 100

func _ready():
	pass

func _physics_process(delta):
	if $bullet1/RayCast3D.is_colliding():
		var body = $bullet1/RayCast3D.get_collider()
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
	global_position += -global_transform.basis.z * speed * delta
