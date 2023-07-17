extends Control

@onready var character_texture: TextureRect = %CharacterTexture
@onready var character_label: Label = %CharacterLabel
@onready var player_name_input: LineEdit = %PlayerNameInput
@onready var button_sounds: AudioStreamPlayer2D = $ButtonSounds
@onready var transition: Transition = $Transition

const CHARACTERS_TYPES: Dictionary = {
	"F": "FEMININO",
	"M": "MASCULINO"
}

var selected_type: String = "M"


func _ready() -> void:
	update_character_in_screen()


func _process(delta: float) -> void:
	update_character_in_screen()

func update_character_in_screen() -> void:
	var character_texture_path: String = MainPlayer.CHARACTERS.get(selected_type)
	character_label.text = CHARACTERS_TYPES.get(selected_type)
	character_texture.texture = load(character_texture_path)

func toggle_type() -> void:
	button_sounds.play()
	match selected_type:
		"F":
			selected_type = "M"
		"M":
			selected_type = "F"


func _on_selected_button_pressed() -> void:
	button_sounds.play()
	MainPlayer.selected_character = selected_type
	MainPlayer.player_name =player_name_input.text
	transition.play_in()
	await transition.animation.animation_finished
	get_tree().change_scene_to_file(Global.APRESENTATION)
