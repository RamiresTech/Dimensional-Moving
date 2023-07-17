extends CharacterBody2D
class_name Player2D

@onready var player_body: Sprite2D = %PlayerBody

const SPEED: float = 300.0


func _ready() -> void:
	var character_texture_path: String = MainPlayer.CHARACTERS.get(
		MainPlayer.selected_character
	)
	player_body.texture = load(character_texture_path)


func _physics_process(delta: float) -> void:
	if Global.is_2d_game_on():
		var direction: Vector2 = Input.get_vector("left", "right", "up", "down")

		velocity = direction * SPEED

		move_and_slide()

		if direction != Vector2.ZERO:
			rotation = direction.angle()
