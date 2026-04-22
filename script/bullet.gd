extends CharacterBody3D

@export var speed: float = 60
@export var damage: int = 25

func _physics_process(delta):
	var motion = -transform.basis.z * speed * delta
	
	var collision = move_and_collide(motion)
	
	if collision:
		var body = collision.get_collider()
		
		if body.is_in_group("enemy"):
			if body.has_method("take_damage"):
				body.take_damage(damage)
		
		queue_free()
