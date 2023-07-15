extends CharacterBody2D


const SPEED = 300.0

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	velocity = direction * SPEED

	move_and_slide()

	if direction != Vector2.ZERO:
		rotation = direction.angle()
