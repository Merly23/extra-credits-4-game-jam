extends Node

var menu_music = preload("res://audio/music/happyFixed.wav")
var game_music = preload("res://audio/music/gameLoop.wav")

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
		$Music/Player.stream = menu_music
		$Music/Player.play()

func play_game_music():
	if $Music/Player.stream != game_music:
		$Music/Player.stream = game_music
		$Music/Player.play()

func stop_music():
	$Ambience.stop()
	$Music/Player.stop()
