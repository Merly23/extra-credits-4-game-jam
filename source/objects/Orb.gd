extends StaticBody2D
class_name Orb

signal destroyed

onready var anim := $AnimationPlayer as AnimationPlayer

func destroy():
	anim.play("destroy")
	Audio.play_orb_smash()

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	emit_signal("destroyed")
	queue_free()
