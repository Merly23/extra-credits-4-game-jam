extends State

var direction := Vector2(0, 0)

var up = false
var down = false
var left = false
var right = false

export var speed := 120

func enter(host):
	host.set_frame_offset(host.facing, host.ANIMATION.WALK)
	host.anim.travel("walk")
	host.sprite.frame = 0

func input(host, event: InputEvent):
	if event.is_action_pressed("mouse_left_button"):
		host.change_state("Attack")

func update(host, delta: float) -> void:
	_movement(host, delta)
	_animation(host)

func _movement(host, delta: float) -> void:
	up = Input.is_action_pressed("ui_up")
	down = Input.is_action_pressed("ui_down")
	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")

	direction.x = -int(left) + int(right)
	direction.y = -int(up) + int(down)

	if direction == Vector2.ZERO:
		host.change_state("Idle")
	else:
		host.move_and_slide(direction.normalized() * speed)

func _animation(host):
	match direction:
		Vector2.UP: host.set_frame_offset(host.FACING.UP, host.ANIMATION.WALK)
		Vector2.DOWN: host.set_frame_offset(host.FACING.DOWN, host.ANIMATION.WALK)
		Vector2.LEFT: host.set_frame_offset(host.FACING.LEFT, host.ANIMATION.WALK)
		Vector2.RIGHT: host.set_frame_offset(host.FACING.RIGHT, host.ANIMATION.WALK)
	pass

