extends State

var motion := Vector2(0, 0)

var up = false
var down = false
var left = false
var right = false

export var speed := 120

func enter(host):
	host.anim.travel("walk")

func update(host, delta: float):
	up = Input.is_action_pressed("ui_up")
	down = Input.is_action_pressed("ui_down")
	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")

	if up and not down:
		host.set_frame_offset(host.FACING.UP, host.ANIMATION.WALK)
		motion.y = -speed * delta
	elif down and not up:
		host.set_frame_offset(host.FACING.DOWN, host.ANIMATION.WALK)
		motion.y = speed * delta
	else:
		motion.y = 0

	if left and not right:
		motion.x = -speed * delta
		host.set_frame_offset(host.FACING.LEFT, host.ANIMATION.WALK)
	elif right and not left:
		motion.x = speed * delta
		host.set_frame_offset(host.FACING.RIGHT, host.ANIMATION.WALK)
	else:
		motion.x = 0

	if motion.length() == 0:
		host.state_machine.change_state("idle")

	host.move_and_collide(motion)

func input(host, event: InputEvent):
	if event.is_action_pressed("mouse_left_button"):
		host.state_machine.change_state("attack")