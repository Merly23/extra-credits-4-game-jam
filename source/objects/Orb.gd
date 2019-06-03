extends Area2D
class_name Orb

onready var anim := $AnimationPlayer as AnimationPlayer

func destroy():
	print("Orb Destroyed")
	anim.play("destroy")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()
