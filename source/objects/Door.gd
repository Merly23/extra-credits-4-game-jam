extends StaticBody2D

export var open_on_start := false

onready var anim := $AnimationPlayer as AnimationPlayer
onready var coll := $CollisionShape2D as CollisionShape2D
onready var ghost_block := $GhostBlock

func _ready() -> void:
	if open_on_start:
		activate(false)

var opened := false

func activate(play_sound: bool = true) -> void:
	opened = true
	anim.play("open")
	coll.disabled = true
	ghost_block.disabled = true
	if play_sound:
		Audio.play_sfx("door")

func deactivate() -> void:
	opened = false
	anim.play_backwards("open")
	coll.disabled = false
	ghost_block.disabled = false
	Audio.play_sfx("door")

func toggle():
	if opened:
		deactivate()
	else:
		activate()