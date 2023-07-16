extends Control


const CREATOR_INSTAGRAM_URL = "https://www.instagram.com/ramirestech.games/"
const CREATOR_LINKEDIN_URL = "https://www.linkedin.com/in/guilherme-ramires-4480a0160/"

@onready var start_button: TextureButton = %StartButton
@onready var quit_button: TextureButton =%QuitButton
@onready var transition: Transition = $Transition
@onready var button_sounds: AudioStreamPlayer2D = $ButtonSounds

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicPlayer.change_music(MusicPlayer.MAIN_MENU_MUSIC)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_button_pressed() -> void:
	button_sounds.play()
	get_tree().quit()


func _on_start_button_pressed() -> void:
	button_sounds.play()
	transition.play_in()
	await transition.animation.animation_finished
	get_tree().change_scene_to_file(Global.GAME_SCREEN)



func _on_instagram_button_pressed() -> void:
	OS.shell_open(CREATOR_INSTAGRAM_URL)


func _on_linkedin_button_pressed() -> void:
	OS.shell_open(CREATOR_LINKEDIN_URL)
