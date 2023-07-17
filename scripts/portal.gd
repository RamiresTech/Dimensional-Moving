extends TextureRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var portal_audio: AudioStreamPlayer2D = %PortalSound


func _ready() -> void:
	Global.change_view.connect(change)


func change() -> void:
	if Global.is_2d_game_on():
		animator.play("2d_to_3d")
	else:
		animator.play("3d_to_2d")
	portal_audio.play()
	await get_tree().create_timer(0.5).timeout
	Global.toggle_view()
