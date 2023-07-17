extends Node

const NORMAL_MUSIC_VOLUME: float = -20
const MINIMUM_MUSIC_VOLUME:float = -80
const TRANSITION_TIME: float = 3

const MUSICS_FOLDER_PATH: String = "res://assets/audios/musics/"

const MAIN_MENU_MUSIC = "res://assets/audios/musics/Remember.mp3"
const GAME_MUSIC = "res://assets/audios/musics/TOMOLI.mp3"

var music_player: AudioStreamPlayer
var actual_music: String

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

func change_music(new_music: String):
	actual_music = new_music.replace(MUSICS_FOLDER_PATH, "")
	if music_player.playing:
		for i in range(60):
			music_player.volume_db -= 1
			await get_tree().create_timer(0.025).timeout
		music_player.stream = load(new_music)
		for i in range(60):
			music_player.volume_db += 1
			await get_tree().create_timer(0.025).timeout
		music_player.volume_db = NORMAL_MUSIC_VOLUME
	else:
		music_player.stream = load(new_music)
		music_player.volume_db = NORMAL_MUSIC_VOLUME
	music_player.play()
