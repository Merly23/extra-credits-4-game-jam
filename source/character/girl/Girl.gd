extends KinematicBody2D

var direction := Vector2()
var path := []

onready var tween := $Tween as Tween
onready var anim := $AnimationPlayer as AnimationPlayer
onready var sprite := $Sprite as Sprite


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_right_button"):
		_make_path()
		tween.stop_all()
		_move()

func _process(delta: float) -> void:
	update()

func _make_path():
	path = Global.Navigation.get_simple_path(global_position, get_global_mouse_position(), false)

func _move():
	if path:
		direction = (path[0] - global_position).normalized()
		tween.interpolate_property(self, "global_position", global_position, path[0], 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		path.remove(0)
		_walk()

func _walk():
	if direction.x < 0 and abs(direction.x) > abs(direction.y):
		_walk_left()
	elif direction.x > 0 and abs(direction.x) > abs(direction.y):
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
	if path:
		_move()
	else:
		_idle()

func _draw():
	if path:
		for point in path:
			draw_circle(to_local(point), 3, Color("FFFFFF"))