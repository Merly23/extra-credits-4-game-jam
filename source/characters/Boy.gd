extends KinematicBody2D

var motion := Vector2()

export var speed := 200

func _process(delta: float) -> void:

	if Input.is_action_pressed("ui_left"):
		motion.x = -speed * delta
	elif Input.is_action_pressed("ui_right"):
		motion.x = speed * delta
	else:
		motion.x = 0
	if Input.is_action_pressed("ui_up"):
		motion.y = -speed * delta
	elif Input.is_action_pressed("ui_down"):
		motion.y = speed * delta
	else:
		motion.y = 0

	move_and_collide(motion)