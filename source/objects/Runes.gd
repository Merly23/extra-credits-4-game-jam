extends Area2D

func _on_Runes_body_entered(body: PhysicsBody2D) -> void:
	if body == Global.Girl:
		body.blocked()
