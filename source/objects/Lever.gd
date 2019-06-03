extends Area2D

signal activated
signal deactivated

var activated = false

onready var anim := $AnimationPlayer as AnimationPlayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and has_player():
		if activated:
			anim.play_backwards("activate")
			activated = false
			emit_signal("deactivated")
			Audio.play_lever()
		else:
			anim.play("activate")
			activated = true
			emit_signal("activated")
			Audio.play_lever()

func has_player() -> bool:
	if Global.Boy and Global.Girl:
		return get_overlapping_bodies().has(Global.Boy) or get_overlapping_bodies().has(Global.Girl)
	return false