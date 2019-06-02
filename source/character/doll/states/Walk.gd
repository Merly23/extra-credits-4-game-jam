extends State

var host

var direction := Vector2(0, 0)
var path := []

var up = false
var down = false
var left = false
var right = false

export var speed := 120

onready var tween := $Tween as Tween
onready var timer := $Timer

func enter(host):
	self.host = host
	host.anim.travel("walk")
	tween.connect("tween_completed", self, "_on_tween_completed")
	call_deferred("_make_path")
	timer.start()

func exit(host):
	timer.stop()

func _animation(host):
	match direction:
		Vector2.UP: host.set_frame_offset(host.FACING.UP, host.ANIMATION.WALK)
		Vector2.DOWN: host.set_frame_offset(host.FACING.DOWN, host.ANIMATION.WALK)
		Vector2.LEFT: host.set_frame_offset(host.FACING.LEFT, host.ANIMATION.WALK)
		Vector2.RIGHT: host.set_frame_offset(host.FACING.RIGHT, host.ANIMATION.WALK)
	pass

func _make_path():
	path = Global.Navigation.get_simple_path(host.global_position, Global.Boy.global_position, false)
	_move()

func _move():
	if path:
		direction = (path[0] - host.global_position).normalized()
		_max_direction()
		_animation(host)
		tween.stop(host)
		tween.interpolate_property(host, "global_position", host.global_position, path[0], 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		path.remove(0)

func _max_direction():
	if direction.x < -0.5: direction.x = -1
	elif direction.x > 0.5: direction.x = 1
	else: direction.x = 0
	if direction.y < -0.5: direction.y = -1
	elif direction.y > 0.5: direction.y = 1
	else: direction.y = 0

func _on_tween_completed(object: Object, key: NodePath) -> void:
	if path:
		_move()
	else:
		host.state_machine.change_state("idle")

func _on_Timer_timeout() -> void:
	_make_path()
	timer.start()

#func _unhandled_input(event: InputEvent) -> void:
#	if event.is_action_pressed("mouse_right_button"):
#		_make_path()
#		tween.stop_all()
#		_move()
#
#func _process(delta: float) -> void:
#	update()
#
#func _make_path():
#	path = Global.Navigation.get_simple_path(global_position, get_global_mouse_position(), false)
#
#
#

#



