extends Area2D

var disabled = false

func _on_GhostBlock_body_entered(body: PhysicsBody2D) -> void:

	if body == Global.Girl and not disabled:
		body.blocked()
		body.knockback(global_position)

	if body is Doll and not disabled:
		body.blocked()
		body.knockback(self)
