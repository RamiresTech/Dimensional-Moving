extends Node


enum game_modes{
	GAME2D,
	GAME3D
}

var game_mode = game_modes.GAME2D


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_view"):
		match game_mode:
			game_modes.GAME2D:
				game_mode = game_modes.GAME3D
			game_modes.GAME3D:
				game_mode = game_modes.GAME2D

func is_2d_game_on() -> bool:
	return game_mode == game_modes.GAME2D
