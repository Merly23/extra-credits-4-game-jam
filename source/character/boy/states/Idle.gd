extends State

var up = false
var down = false
var left = false
var right = false

func enter(host):
	host.set_frame_offset(host.facing, host.ANIMATION.IDLE)
	host.anim.travel("idle")

func exit(host):
	.exit(host)
	pass

func update(host, delta: float):
	up = Input.is_action_pressed("ui_up")
	down = Input.is_action_pressed("ui_down")
	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")

	if up or down or left or right:
		host.state_machine.change_state("walk")

func input(host, event: InputEvent):
	if event.is_action_pressed("mouse_left_button"):
		host.state_machine.change_state("attack")