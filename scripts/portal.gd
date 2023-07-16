extends TextureRect

@onready var animator: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	Global.change_view.connect(change)


func change() -> void:
	animator.play("change")
	await get_tree().create_timer(0.5).timeout
	Global.toggle_view()
