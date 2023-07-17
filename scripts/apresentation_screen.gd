extends Control

@onready var messages_box: VBoxContainer = %MessagesBox
@onready var next_button: TextureButton = %Next
@onready var start_button: TextureButton = %StartButton
@onready var transition: Transition = $Transition
@onready var button_sounds: AudioStreamPlayer2D = $ButtonSounds

const MESSAGE_CONTAINER = preload("res://scenes/menus/chat_message.tscn")
const RULES_CONTAINER = preload("res://scenes/menus/rules.tscn")

var step: int = 0

var first_message: Dictionary = {
	"F":"Olá, você deve ser a nova funcionária, prazer em conhecela " + MainPlayer.player_name + ", eu me chamo Alice e vou explicar qual será seu trabalho aqui.",
	"M":"Olá, você deve ser o cara novo, prazer em conhecelo " + MainPlayer.player_name + ", eu me chamo Alice e vou explicar qual será seu trabalho aqui.",
}

var messages: Array[String] = [
	"Nós somos a Dimensional Moving, uma empresa focada em venda de móveis para viajantes interdimensionais.",
	"Os nossos clientes necessitam de móveis que existam em mais de uma dimensão, a nossa que eles chamam de dimensão 2D, e a deles a 3D.",
	"Seu trabalho será organizar os móveis no espaço do cliente, conforme solicitado na ordem de serviço nas duas dimensões.",
	"Para isso você contará com um dispositivo de deslocamento dimensional, que você pode utilizar presionando V."
]


func _ready() -> void:
	var message = first_message.get(MainPlayer.selected_character)
	create_new_message(message)


func create_new_message(message: String) -> void:
	var chat_instance = MESSAGE_CONTAINER.instantiate() as ChatMessage
	chat_instance.text_to_type = message
	messages_box.add_child(chat_instance)



func _on_next_pressed() -> void:
	button_sounds.play()
	var new_message: String = messages[step]
	step += 1
	create_new_message(new_message)

	if step == messages.size():
		start_button.show()
		next_button.hide()
		for child in messages_box.get_children():
			child.queue_free()
		var rules = RULES_CONTAINER.instantiate()
		messages_box.add_child(rules)



func _on_start_button_pressed() -> void:
	button_sounds.play()
	transition.play_in()
	await transition.animation.animation_finished
	get_tree().change_scene_to_file(Global.GAME_SCREEN)
