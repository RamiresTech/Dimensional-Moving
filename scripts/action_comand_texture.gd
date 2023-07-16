extends TextureRect

var action_textures: Dictionary = {
	MainPlayer.actions.PUSH: preload("res://assets/sprites/GUI/Comands/character_lift.png"),
	MainPlayer.actions.PULL: preload("res://assets/sprites/GUI/Comands/character_place.png"),
	MainPlayer.actions.TURN_TO_LEFT: preload("res://assets/sprites/GUI/Comands/arrow_counterclockwise.png"),
	MainPlayer.actions.TURN_TO_RIGHT: preload("res://assets/sprites/GUI/Comands/arrow_clockwise.png")
}


func _ready() -> void:
	texture = action_textures.get(MainPlayer.selected_action)


func _process(delta: float) -> void:
	texture = action_textures.get(MainPlayer.selected_action)
