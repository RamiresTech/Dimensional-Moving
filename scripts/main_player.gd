extends Node


enum actions{
	PUSH,
	PULL,
	TURN_TO_RIGHT,
	TURN_TO_LEFT
}

var selected_action = actions.PUSH

func toggle_action() -> void:
	match selected_action:
		actions.PUSH:
			selected_action = actions.PULL
		actions.PULL:
			selected_action = actions.TURN_TO_LEFT
		actions.TURN_TO_LEFT:
			selected_action = actions.TURN_TO_RIGHT
		actions.TURN_TO_RIGHT:
			selected_action = actions.PUSH
