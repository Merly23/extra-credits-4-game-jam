extends StaticBody2D

onready var anim := $AnimationPlayer as AnimationPlayer
onready var coll := $CollisionShape2D as CollisionShape2D

var opened := false

func activate() -> void:
	opened = true
	anim.play("open")
	coll.disabled = true
	Audio.play_plate()

func deactivate() -> void:
	opened = false
	anim.play_backwards("open")
	coll.disabled = false
	Audio.play_plate()

func toggle():
	if opened:
		deactivate()
	else:
		activate()