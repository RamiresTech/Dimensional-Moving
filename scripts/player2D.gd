extends CharacterBody2D


const SPEED = 300.0

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")

	velocity = direction * SPEED

	move_and_slide()

	if direction != Vector2.ZERO:
		rotation = direction.angle()
