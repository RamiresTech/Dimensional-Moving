extends Node2D


func _process(delta: float) -> void:
	self.visible = Global.is_2d_game_on()
