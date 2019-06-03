extends Area2D

signal activated
signal deactivated

onready var anim := $AnimationPlayer as AnimationPlayer

func _on_Lever_body_entered(body: PhysicsBody2D) -> void:
	if body == Global.Boy:
		anim.play("activate")
		emit_signal("activated")

func _on_Lever_body_exited(body: PhysicsBody2D) -> void:
	if body == Global.Boy:
		anim.play_backwards("activate")
		emit_signal("deactivated")