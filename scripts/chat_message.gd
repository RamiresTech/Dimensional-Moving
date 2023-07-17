extends HBoxContainer
class_name ChatMessage


@onready var message_label: Label = %Message

@export var text_to_type: String = ""

var current_text: String = ""
var typing_timer: float = 0.0
var typing_index: int = 0
var typing_speed: float = 0
var typing_speed_min: float = 0.03
var typing_speed_max: float = 0.01

func _ready():
	current_text = ""
	typing_timer = 0.0
	typing_index = 0
	update_label_text()

	# Define a velocidade de digitação aleatória
	typing_speed = randf_range(typing_speed_min, typing_speed_max)

func _process(delta: float):
	typing_timer += delta

	if typing_timer >= typing_speed and typing_index < text_to_type.length():
		typing_timer = 0.0
		current_text += text_to_type[typing_index]
		typing_index += 1
		update_label_text()

func update_label_text():
	message_label.text = current_text
