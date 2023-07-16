extends Label
class_name CountDown

@export var countdown_minutes: int = 5
@export var countdown_seconds: int = 0

signal time_over

func _ready():
	var total_seconds = countdown_minutes * 60 + countdown_seconds
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60

	text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)

func start_countdown() -> void:
	var total_seconds = countdown_minutes * 60 + countdown_seconds

	while total_seconds > 0:
		var minutes = total_seconds / 60
		var seconds = total_seconds % 60

		text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)

		await get_tree().create_timer(1.0).timeout
		total_seconds -= 1

	text = "Fim!"
	modulate = Color.RED
	time_over.emit()

