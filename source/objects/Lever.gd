extends StaticBody2D

signal activated
signal deactivated

var activated = false

onready var anim := $AnimationPlayer as AnimationPlayer
onready var area := $Area2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and has_player():
		if activated:
			anim.play_backwards("activate")
			activated = false
			Audio.play_lever()
			yield(get_tree().create_timer(0.3), "timeout")
			emit_signal("deactivated")
		else:
			anim.play("activate")
			activated = true
			Audio.play_lever()
			yield(get_tree().create_timer(0.3), "timeout")
			emit_signal("activated")

func has_player() -> bool:
	if Global.Boy and Global.Girl:
		return area.get_overlapping_bodies().has(Global.Boy) or area.get_overlapping_bodies().has(Global.Girl)
	return false