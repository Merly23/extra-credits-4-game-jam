extends Node

var menu_music = preload("res://audio/music/happyFixed.wav")
var game_music = preload("res://audio/music/gameLoop.wav")

onready var music_player := $Music/Player as AudioStreamPlayer

onready var boy_footstep := $Boy/Footstep as AudioStreamPlayer
onready var boy_slash := $Boy/Slash as AudioStreamPlayer
onready var doll_slash := $Doll/Slash as AudioStreamPlayer

func _ready() -> void:
	boy_footstep.volume_db = linear2db(0.05)

func play_boy_foodstep():
	randomize()
	boy_footstep.pitch_scale = rand_range(0.9, 1.1)
	boy_footstep.play()

func play_boy_slash():
	boy_slash.play()

func play_doll_slash():
	doll_slash.play()

func play_menu_music():
	if music_player.stream != menu_music:
		music_player.stream = menu_music
		music_player.play()

func play_game_music():
	if music_player.stream != game_music:
		music_player.stream = game_music
		music_player.play()

func stop_music():
	music_player.stop()
