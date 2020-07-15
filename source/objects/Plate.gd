extends Area2D

signal activated
signal deactivated

onready var anim := $AnimationPlayer as AnimationPlayer

func _on_Lever_body_entered(body: PhysicsBody2D) -> void:
	if body == Global.Boy:
		anim.play("activate")
		Audio.play_sfx("plate")
		yield(get_tree().create_timer(0.3), "timeout")
		emit_signal("activated")

func _on_Lever_body_exited(body: PhysicsBody2D) -> void:
	if body == Global.Boy:
		anim.play_backwards("activate")
		Audio.play_sfx("plate")
		yield(get_tree().create_timer(0.3), "timeout")
		emit_signal("deactivated")
