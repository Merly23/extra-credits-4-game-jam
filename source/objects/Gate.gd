extends StaticBody2D

export var open_on_start := false

onready var anim := $AnimationPlayer as AnimationPlayer
onready var coll := $CollisionShape2D as CollisionShape2D

var opened := false

func _ready() -> void:
	if open_on_start:
		activate(false)

func activate(play_sound: bool = true) -> void:
	opened = true
	anim.play("open")
	coll.disabled = true
	if play_sound:
		Audio.play_gate()

func deactivate() -> void:
	opened = false
	anim.play_backwards("open")
	coll.disabled = false
	Audio.play_gate()

func toggle():
	if opened:
		deactivate()
	else:
		activate()
