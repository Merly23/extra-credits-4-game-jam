extends Area2D

func _on_Portal_body_entered(body: PhysicsBody2D) -> void:
	if body == Global.Boy:
		Scene.change(Scene.Victory)
