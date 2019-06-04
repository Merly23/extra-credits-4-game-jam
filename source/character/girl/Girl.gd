extends KinematicBody2D
class_name Girl

var direction := Vector2()
var path := []

onready var tween := $Tween as Tween
onready var anim := $AnimationPlayer as AnimationPlayer
onready var sprite := $Sprite as Sprite

onready var heal_area := $HealArea

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_right_button"):
		_make_path()
		tween.stop_all()
		_move()

func _ready() -> void:
	Global.Girl = self

func _process(delta: float) -> void:
	update()

func blocked():
	tween.stop_all()
	path = []

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

func knockback(center: Vector2):
	var knockback = 15

	var direction = (center - global_position).normalized()

	tween.interpolate_property(self, "global_position", global_position, global_position + knockback * -direction, 0.1, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if path:
		_move()
	else:
		_idle()

func _draw():
	if path:
		for point in path:
			draw_circle(to_local(point), 3, Color("FFFFFF"))

func _on_Timer_timeout() -> void:
	var bodies = heal_area.get_overlapping_bodies()
	if bodies.has(Global.Boy) and not Global.Boy.is_health_max():
		Global.Boy.heal(2)
