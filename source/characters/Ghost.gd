extends KinematicBody2D

var direction := Vector2()

onready var tween := $Tween as Tween
onready var anim := $AnimationPlayer as AnimationPlayer
onready var sprite := $Sprite as Sprite

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left_button") and not tween.is_active():
		var mouse_position = get_global_mouse_position()
		direction = (mouse_position - global_position).normalized();
		tween.interpolate_property(self, "global_position", global_position, mouse_position, 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()
		_walk()

func _walk():
	if direction.x < 0:
		_walk_left()
	elif direction.x > 0:
		_walk_right()
	elif direction.y < abs(direction.x):
		_walk_up()
	elif direction.y > abs(direction.x):
		_walk_down()

func _walk_up():
	anim.play("walk_up")

func _walk_down():
	anim.play("walk_down")

func _walk_left():
	anim.play("walk_right")
	sprite.flip_h = true

func _walk_right():
	anim.play("walk_right")
	sprite.flip_h = false

func _idle():
	anim.play("idle")

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	_idle()
