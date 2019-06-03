extends Node

onready var boy_footstep := $Boy/Footstep as AudioStreamPlayer
onready var boy_slash := $Boy/Slash as AudioStreamPlayer

func _ready() -> void:
	boy_footstep.volume_db = linear2db(0.05)

func play_boy_foodstep():
	randomize()
	boy_footstep.pitch_scale = rand_range(0.9, 1.1)
	boy_footstep.play()

func play_boy_slash():
	boy_slash.play()