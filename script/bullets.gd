extends Area3D

@export var speed: float = 1
@export var damage: int = 100

func _ready():
	pass

func _physics_process(delta):
	if $RayCast3D.is_colliding():
		var target = $RayCast3D.get_collider()
		print("HIT:", target)
		
		if target.name != "Player":
			queue_free()
			
	global_position += -global_transform.basis.z * speed * delta
