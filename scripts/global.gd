extends Node

# Scenes Path
const MAIN_MENU: String = "res://scenes/menus/main_menu.tscn"
const CHARACTER_SELECTION: String = "res://scenes/menus/select_player.tscn"
const APRESENTATION: String = "res://scenes/menus/apresentation_screen.tscn"
const GAME_SCREEN: String ="res://scenes/levels/level.tscn"


enum game_modes{
	GAME2D,
	GAME3D
}


var game_mode = game_modes.GAME2D

signal change_view


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_view"):
		change_view.emit()

func toggle_view() -> void:
	match game_mode:
		game_modes.GAME2D:
			game_mode = game_modes.GAME3D
		game_modes.GAME3D:
			game_mode = game_modes.GAME2D


func is_2d_game_on() -> bool:
	return game_mode == game_modes.GAME2D
