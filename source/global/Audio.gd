extends Node

var menu_music = preload("res://audio/music/happyFixed.wav")
var game_music = preload("res://audio/music/gameLoop.wav")

var volume : float setget _set_volume

onready var sfx := {
	"boy_footstep": $Boy/Footstep,
	"boy_slash": $Boy/Slash,
	"boy_hit": $Boy/Hit,
	"doll_slash": $Doll/Slash,
	"doll_hit": $Doll/Hit,
	"doll_die": $Doll/Die,
	"lever": $Lever,
	"plate": $Plate,
	"door": $Door,
	"gate": $Lever,
	"button_hover": $Button/Hover,
	"button_pressed": $Button/Pressed,
	"orb_smash": $OrbSmash,
}

onready var tween := $Tween as Tween

onready var music_booth := $MusicBooth

func _ready() -> void:
	_set_volume(1.0)

func play_sfx(sfx_name: String) -> void:

	if sfx_name == "boy_footstep":
		sfx[sfx_name].pitch_scale = rand_range(0.9, 1.1)

	sfx[sfx_name].play()

func play_ambience():
	$Ambience.play()

func play_boy_foodstep():
	randomize()
	$Boy/Footstep.pitch_scale = rand_range(0.9, 1.1)
	$Boy/Footstep.play()

func play_song(song_name: String, fade_time := 0.0) -> void:
	music_booth.play_song(song_name, fade_time)

func stop_music():
	$Ambience.stop()
	music_booth.stop_song()

func _set_volume(value):
	volume = value
	AudioServer.set_bus_volume_db(0, linear2db(volume))
