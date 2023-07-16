extends Label


var actions_names: Dictionary = {
	MainPlayer.actions.PUSH: "Empurrar",
	MainPlayer.actions.PULL: "Puxar",
	MainPlayer.actions.TURN_TO_LEFT: "Girar para a direita",
	MainPlayer.actions.TURN_TO_RIGHT: "Girar para a esquerda"
}

func _process(delta: float) -> void:
	text = actions_names.get(MainPlayer.selected_action)
