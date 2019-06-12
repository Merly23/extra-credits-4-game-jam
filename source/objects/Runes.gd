extends Area2D

onready var anim := $AnimationPlayer as AnimationPlayer

func destroy():
	anim.play("destroyed")

func _on_Runes_body_entered(body: PhysicsBody2D) -> void:
	if body == Global.Girl:
		body.blocked()
		body.knockback(global_position)

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()