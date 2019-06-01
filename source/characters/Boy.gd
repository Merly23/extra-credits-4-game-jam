extends KinematicBody2D

var motion := Vector2()

export var speed := 200
export var damage := 1

onready var stick_area := $StickArea

onready var anim := $AnimationPlayer
onready var sprite := $Sprite

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_right_button"):
		_attack()

func _process(delta: float) -> void:

	if Input.is_action_pressed("ui_left"):
		motion.x = -speed * delta
		anim.play("walk_right")
		sprite.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		motion.x = speed * delta
		anim.play("walk_right")
		sprite.flip_h = false
	else:
		motion.x = 0
		anim.play("idle")

	if Input.is_action_pressed("ui_up"):
		motion.y = -speed * delta
		anim.play("walk_up")
	elif Input.is_action_pressed("ui_down"):
		motion.y = speed * delta
		anim.play("walk_down")
	else:
		motion.y = 0
		anim.play("idle")

	move_and_collide(motion)

func _attack() -> void:
	var areas = stick_area.get_overlapping_areas()
	for area in areas:
		if area is Attackable:
			area.harm(damage)