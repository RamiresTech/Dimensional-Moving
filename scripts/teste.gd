extends Label


func _physics_process(delta: float) -> void:
	var actual_game_mode = Global.game_mode

	match actual_game_mode:
		Global.game_modes.GAME2D:
			text = "2D MODE"
		Global.game_modes.GAME3D:
			text = "3D MODE"
