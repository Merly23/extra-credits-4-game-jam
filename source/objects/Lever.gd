extends Area2D
class_name Orb

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
		else:
			anim.play("activate")
			activated = true
			emit_signal("activated")

func has_player() -> bool:
	if Global.Boy:
		return get_overlapping_bodies().has(Global.Boy)
	return false