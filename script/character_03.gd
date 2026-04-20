# ProtoController v1.0 by Brackeys
# + Shooting system FIXED

extends CharacterBody3D

# 🔫 CAMERA + BULLET
@onready var camera: Camera3D = $Head/Camera3D

@export var bullet_scene: PackedScene
@export var bullet_speed: float = 60.0

## Can we move around?
@export var can_move : bool = true
@export var has_gravity : bool = true
@export var can_jump : bool = true
@export var can_sprint : bool = false
@export var can_freefly : bool = false

@export_group("Speeds")
@export var look_speed : float = 0.002
@export var base_speed : float = 7.0
@export var jump_velocity : float = 4.5
@export var sprint_speed : float = 10.0
@export var freefly_speed : float = 25.0

@export_group("Input Actions")
@export var input_left : String = "left"
@export var input_right : String = "right"
@export var input_forward : String = "front"
@export var input_back : String = "back"
@export var input_jump : String = "jump"
@export var input_sprint : String = "sprint"
@export var input_freefly : String = "freefly"
@export var input_shoot : String = "shoot"

var mouse_captured : bool = false
var look_rotation : Vector2
var move_speed : float = 0.0
var freeflying : bool = false

@onready var head: Node3D = $Head
@onready var collider: CollisionShape3D = $Collider

func _unhandled_input(event: InputEvent) -> void:
	# Mouse capture
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		capture_mouse()
	if Input.is_key_pressed(KEY_ESCAPE):
		release_mouse()
	
	# Look
	if mouse_captured and event is InputEventMouseMotion:
		rotate_look(event.relative)

	# 🔥 FIXED SHOOT INPUT (no spam / no weird behavior)
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		shoot()
	
	# Freefly toggle
	if can_freefly and Input.is_action_just_pressed(input_freefly):
		if not freeflying:
			enable_freefly()
		else:
			disable_freefly()

func _physics_process(delta: float) -> void:
	if can_freefly and freeflying:
		var input_dir := Input.get_vector(input_left, input_right, input_forward, input_back)
		var motion := (head.global_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		motion *= freefly_speed * delta
		move_and_collide(motion)
		return
	
	if has_gravity:
		if not is_on_floor():
			velocity += get_gravity() * delta

	if can_jump:
		if Input.is_action_just_pressed(input_jump) and is_on_floor():
			velocity.y = jump_velocity

	if can_sprint and Input.is_action_pressed(input_sprint):
		move_speed = sprint_speed
	else:
		move_speed = base_speed

	if can_move:
		var input_dir := Input.get_vector(input_left, input_right, input_forward, input_back)
		var move_dir := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if move_dir:
			velocity.x = move_dir.x * move_speed
			velocity.z = move_dir.z * move_speed
		else:
			velocity.x = move_toward(velocity.x, 0, move_speed)
			velocity.z = move_toward(velocity.z, 0, move_speed)
	else:
		velocity = Vector3.ZERO
	
	move_and_slide()

# 🔫 FIXED SHOOT FUNCTION
func shoot():
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)

	bullet.global_transform.basis = camera.global_transform.basis.orthonormalized()

	bullet.global_position = camera.global_transform.origin + -camera.global_transform.basis.z
 




	


func rotate_look(rot_input : Vector2):
	look_rotation.x -= rot_input.y * look_speed
	look_rotation.x = clamp(look_rotation.x, deg_to_rad(-85), deg_to_rad(85))
	look_rotation.y -= rot_input.x * look_speed
	transform.basis = Basis()
	rotate_y(look_rotation.y)
	head.transform.basis = Basis()
	head.rotate_x(look_rotation.x)

func enable_freefly():
	collider.disabled = true
	freeflying = true
	velocity = Vector3.ZERO

func disable_freefly():
	collider.disabled = false
	freeflying = false

func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false

func check_input_mappings():
	if can_move and not InputMap.has_action(input_left):
		push_error("Missing: " + input_left)
	if can_move and not InputMap.has_action(input_right):
		push_error("Missing: " + input_right)
	if can_move and not InputMap.has_action(input_forward):
		push_error("Missing: " + input_forward)
	if can_move and not InputMap.has_action(input_back):
		push_error("Missing: " + input_back)
	if can_jump and not InputMap.has_action(input_jump):
		push_error("Missing: " + input_jump)
	if can_sprint and not InputMap.has_action(input_sprint):
		push_error("Missing: " + input_sprint)
	if can_freefly and not InputMap.has_action(input_freefly):
		push_error("Missing: " + input_freefly)
