extends Node

var menu_music = preload("res://audio/music/happyFixed.wav")
var game_music = preload("res://audio/music/gameLoop.wav")

var volume : float setget _set_volume

onready var tween := $Tween as Tween

func _ready() -> void:
	_set_volume(1.0)

func play_ambience():
	$Ambience.play()

func play_boy_foodstep():
	randomize()
	$Boy/Footstep.pitch_scale = rand_range(0.9, 1.1)
	$Boy/Footstep.play()

func play_boy_slash():
	$Boy/Slash.play()

func play_boy_hit():
	$Boy/Hit.play()

func play_doll_slash():
	$Doll/Slash.play()

func play_doll_hit():
	$Doll/Hit.play()

func play_doll_die():
	$Doll/Die.play()

func play_lever():
	$Lever.play()

func play_plate():
	$Plate.play()

func play_door():
	$Door.play()

func play_gate():
	$Gate.play()

func play_button():
	$Button.play()

func play_orb_smash():
	$OrbSmash.play()

func play_menu_music():
	if $Music/Player.stream != menu_music:

		tween.interpolate_property(self, "volume", 1.0, 0.0, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

		yield(tween, "tween_completed")

		$Music/Player.stream = menu_music
		$Music/Player.play()
		$Ambience.stop()

		tween.interpolate_property(self, "volume", 0.0, 1.0, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

func play_game_music():
	if $Music/Player.stream != game_music:

		tween.interpolate_property(self, "volume", 1.0, 0.0, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

		yield(tween, "tween_completed")

		$Music/Player.stream = game_music
		$Music/Player.play()
		$Ambience.play()

		tween.interpolate_property(self, "volume", 0.0, 1.0, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

func stop_music():
	$Ambience.stop()
	$Music/Player.stop()

func _set_volume(value):
	volume = value
	AudioServer.set_bus_volume_db(0, linear2db(volume))
