extends CharacterBody3D

@onready var head: Node3D = %Head

const SPEED = 5.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_sensitivity: float = 0.3
var mouse_is_visible: float = false
var direction: Vector3

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta: float) -> void:
	__move(delta)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		mouse_is_visible = !mouse_is_visible
		if mouse_is_visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func __move(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	var body_rotation = global_transform.basis.get_euler().y
	var input_dir := Input.get_vector("left", "right", "up", "down")
	direction = Vector3(input_dir.x, 0, input_dir.y).rotated(Vector3.UP, body_rotation)
	direction = direction.normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and not mouse_is_visible:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-45), deg_to_rad(90))


