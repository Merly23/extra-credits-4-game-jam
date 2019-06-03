extends Area2D
class_name Orb

onready var anim := $AnimationPlayer as AnimationPlayer

func destroy():
	anim.play("destroy")
	Audio.play_orb_smash()

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()
