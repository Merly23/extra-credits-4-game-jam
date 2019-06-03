extends StaticBody2D

onready var anim := $AnimationPlayer as AnimationPlayer
onready var coll := $CollisionShape2D as CollisionShape2D
onready var ghost_block := $GhostBlock

var opened := false

func activate() -> void:
	opened = true
	anim.play("open")
	coll.disabled = true
	ghost_block.disabled = true

func deactivate() -> void:
	opened = false
	anim.play_backwards("open")
	coll.disabled = false
	ghost_block.disabled = false

func toggle():
	if opened:
		deactivate()
	else:
		activate()